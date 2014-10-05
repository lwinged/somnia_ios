//
//  SMAResetPasswordViewController.h
//  Somnia
//
//  Created by flav on 05/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAResetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

-(BOOL) validateEmail:(NSString*) emailString;
- (void) showAlert:(NSString *) title :(NSString *) message;


@end
