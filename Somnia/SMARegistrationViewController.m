//
//  SMARegistrationViewController.m
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMARegistrationViewController.h"

@interface SMARegistrationViewController ()

@end

@implementation SMARegistrationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailTextField.delegate = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (IBAction)registerAction:(id)sender
{
    NSLog(@"register");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
