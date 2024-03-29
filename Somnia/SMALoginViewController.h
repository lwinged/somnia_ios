//
//  SMALoginViewController.h
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMADataHandler.h"

/**
 LoginViewController - login view
 */

@interface SMALoginViewController : UIViewController <UITextFieldDelegate>

/**
 username field
 */

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

/**
 password field
 */

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (nonatomic, strong) SMADataHandler * dataHandler;


/**
 start login request to web server when login button is pressed
 */
- (IBAction)loginAction:(id)sender;

/**
 hide keybord when return button is pressed
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;



@end
