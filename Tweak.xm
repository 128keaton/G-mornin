#import <UIKit/UIKit.h>
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.128keaton.gmorning.plist"];

#define kScreenTag 73737334
NSString *alpineIsTheDefaultPassword = nil;
%group iOS7
@interface SBLockScreenView : UIView
@end



SBLockScreenView *lockScreenView = nil;


unsigned long long *theFinalCountdown = nil;


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
   
    
    if([prefs objectForKey:@"username"]!= nil){
        alpineIsTheDefaultPassword = [prefs objectForKey:@"username"];
    }else{
        alpineIsTheDefaultPassword = @"Mr X.";
    }
    
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
    
        NSDate *date = [NSDate date];
        
        // Make Date Formatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh a"];
        
        // hh for hour mm for minutes and a will show you AM or PM
        NSString *str = [dateFormatter stringFromDate:date];
        NSLog(@"%@", str);
        
        // Sperate str by space i.e. you will get time and AM/PM at index 0 and 1 respectively
        NSArray *array = [str componentsSeparatedByString:@" "];
        
        // Now you can check it by 12. If < 12 means Its morning > 12 means its evening or night
        
        NSString *message = nil;
    NSString *personName = alpineIsTheDefaultPassword;
        NSString *timeInHour = array[0];
        NSString *am_pm      = array[1];
        
        if([timeInHour integerValue] < 12 && [am_pm isEqualToString:@"AM"])
        {
            greetingLabel.text = [NSString stringWithFormat:@"Good Morning %@", personName];
        }
        else if ([timeInHour integerValue] <= 4 && [am_pm isEqualToString:@"PM"])
        {
            greetingLabel.text = [NSString stringWithFormat:@"Good Afternoon %@", personName];
        }
        else if ([timeInHour integerValue] > 4 && [am_pm isEqualToString:@"PM"])
        {
            greetingLabel.text = [NSString stringWithFormat:@"Good Night %@", personName];
        }
        
        
        NSLog(@"%@", message);
        
    
        
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
    if([prefs objectForKey:@"username"] != nil){
        alpineIsTheDefaultPassword = [prefs objectForKey:@"username"];
    }else{
        alpineIsTheDefaultPassword = @"Mr X.";
    }
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
    
    NSDate *date = [NSDate date];
    
    // Make Date Formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh a"];
    
    // hh for hour mm for minutes and a will show you AM or PM
    NSString *str = [dateFormatter stringFromDate:date];
    NSLog(@"%@", str);
    
    // Sperate str by space i.e. you will get time and AM/PM at index 0 and 1 respectively
    NSArray *array = [str componentsSeparatedByString:@" "];
    
    // Now you can check it by 12. If < 12 means Its morning > 12 means its evening or night
    
    NSString *message = nil;
    NSString *personName =  alpineIsTheDefaultPassword;
    NSString *timeInHour = array[0];
    NSString *am_pm      = array[1];
    
    if([timeInHour integerValue] < 12 && [am_pm isEqualToString:@"AM"])
    {
        greetingLabel.text = [NSString stringWithFormat:@"Good Morning %@", personName];
    }
    else if ([timeInHour integerValue] <= 4 && [am_pm isEqualToString:@"PM"])
    {
        greetingLabel.text = [NSString stringWithFormat:@"Good Afternoon %@", personName];
    }
    else if ([timeInHour integerValue] > 4 && [am_pm isEqualToString:@"PM"])
    {
        greetingLabel.text = [NSString stringWithFormat:@"Good Night %@", personName];
    }
    
    
    NSLog(@"%@", message);
    
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