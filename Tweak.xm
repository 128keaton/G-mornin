#import <UIKit/UIKit.h>

#define kScreenTag 73737334
%group iOS7
@interface SBLockScreenView : UIView
@end



SBLockScreenView *lockScreenView = nil;


%hook SBLockScreenView

-(id)initWithFrame:(id)arg1{
    id r = %orig;
    if (r) {
        lockScreenView = r;
    }
    return r;
}

%end
%hook SBLockScreenDateViewController
-(void)_updateView{
    %orig;
    NSLog(@"staying alive");
    UILabel *greetingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,lockScreenView.frame.size.width /2,150)];
    [greetingLabel setCenter: lockScreenView.center];
    greetingLabel.numberOfLines = 0;
    greetingLabel.lineBreakMode = NSLineBreakByWordWrapping;
    greetingLabel.textAlignment =  NSTextAlignmentCenter;
    greetingLabel.font = [greetingLabel.font fontWithSize: 25];
    greetingLabel.textColor = [UIColor whiteColor];
    greetingLabel.alpha = 0.0;
    greetingLabel.tag = kScreenTag;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger hour = [dateComponents hour];
    if (hour < 12)
    {
        greetingLabel.text = @"Good morning!";
    }
    else if (hour > 12 && hour <= 16)
    {
        greetingLabel.text = @"Good afternoon!";
    }
    else
    {
        greetingLabel.text = @"Good night!";
    }
     UILabel *dieLabel = (UILabel *)[lockScreenView viewWithTag:kScreenTag];
    if(dieLabel == nil){
        [lockScreenView insertSubview:greetingLabel atIndex: 0];
    }
    [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             greetingLabel.alpha = 1.0;
                         }
                     completion:^(BOOL finished) {
                        
                     }];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(removeLabel:)
                                   userInfo:nil
                                    repeats:NO];
    
}
%new(v@:)
-(void)removeLabel:(NSTimer*)timer
{
    NSLog(@"Tick...");
    UILabel *dieLabel = (UILabel *)[lockScreenView viewWithTag:kScreenTag];
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         dieLabel.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [dieLabel removeFromSuperview];
                         
                     }];
  

}


%end

%end

%group iOS6

@interface SBAwayDateView : UIView
@end



SBAwayDateView *awayScreenView = nil;

%hook SBAwayView

-(id)initWithFrame:(struct CGRect)arg1{
    id r = %orig;
    if (r) {
        awayScreenView = r;
    }
    return r;
}

-(void)updateInterface{
    %orig;
    NSLog(@"staying alive");
    UILabel *greetingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,awayScreenView.frame.size.width /2,150)];
    [greetingLabel setCenter: awayScreenView.center];
    greetingLabel.numberOfLines = 0;
    greetingLabel.lineBreakMode = NSLineBreakByWordWrapping;
    greetingLabel.textAlignment =  NSTextAlignmentCenter;
    greetingLabel.font = [greetingLabel.font fontWithSize: 25];
    greetingLabel.textColor = [UIColor whiteColor];
    greetingLabel.backgroundColor = [UIColor clearColor];
    greetingLabel.alpha = 0.0;
    greetingLabel.tag = kScreenTag;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger hour = [dateComponents hour];
    if (hour < 12)
    {
        greetingLabel.text = @"Good morning!";
    }
    else if (hour > 12 && hour <= 16)
    {
        greetingLabel.text = @"Good afternoon!";
    }
    else
    {
        greetingLabel.text = @"Good night!";
    }
    UILabel *dieLabel = (UILabel *)[lockScreenView viewWithTag:kScreenTag];
    if(dieLabel == nil){
        [awayScreenView  addSubview:greetingLabel];
    }
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         greetingLabel.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(removeLabel:)
                                   userInfo:nil
                                    repeats:NO];
    
}
%new(v@:)
-(void)removeLabel:(NSTimer*)timer
{
    NSLog(@"Tick...");
    UILabel *dieLabel = (UILabel *)[awayScreenView viewWithTag:kScreenTag];
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         dieLabel.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [dieLabel removeFromSuperview];
                         
                     }];
    
    
}


%end




%end

%ctor {
    if(kCFCoreFoundationVersionNumber>= kCFCoreFoundationVersionNumber_iOS_7_0){
        %init(iOS7);
    }else{
        %init(iOS6);
    }
}