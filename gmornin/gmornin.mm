#import <Preferences/Preferences.h>

@interface gmorninListController: PSListController {
}
@end

@implementation gmorninListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"gmornin" target:self] retain];
	}
	return _specifiers;
}
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-(void)respring{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Question"
                                                     message:@"Do you want to respring?"
                                                    delegate:self
                                           cancelButtonTitle:@"No"
                                           otherButtonTitles: nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    
    [self.view endEditing:YES];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   
    if (buttonIndex == 0)
    {
        NSLog(@"You have clicked Cancel");
    }
    else if(buttonIndex == 1)
    {
         system("killall backboardd");
    }
}

#pragma GCC diagnostic pop
@end

// vim:ft=objc
