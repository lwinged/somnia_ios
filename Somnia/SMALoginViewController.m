//
//  SMALoginViewController.m
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMALoginViewController.h"

@interface SMALoginViewController ()

@end

@implementation SMALoginViewController

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
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    // Do any additional setup after loading the view.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)loginAction:(id)sender
{
    NSLog(@"login");
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
