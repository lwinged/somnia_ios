//
//  SMAResetPasswordViewController.h
//  Somnia
//
//  Created by flav on 05/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAResetPasswordViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


/**
 hide keybord when return button is pressed
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
