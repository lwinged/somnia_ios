//
//  SMARegistrationViewController.h
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 RegsitrationViewController - sign up form
 */
@interface SMARegistrationViewController : UIViewController <UITextFieldDelegate>

/**
email field
 */
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
/**
 usename field
 */
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

/**
 password field
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


/**
 start registration request to web server when registration button is pressed
 */
- (IBAction)registerAction:(id)sender;

/**
 hide keybord when return button is pressed
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
