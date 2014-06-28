//
//  SMALoginViewController.h
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMALoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end
