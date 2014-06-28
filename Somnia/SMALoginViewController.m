//
//  SMALoginViewController.m
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMALoginViewController.h"

#import "AFHTTPSessionManager.h"
#import "SMAGlobal.h"

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
    
    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""])
    {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
        [manager GET:[NSString stringWithFormat:@"%@/login/token", _env] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"html %@", responseObject);
            NSDictionary *jsonObject = responseObject;
            //jsonObject[@"token"];
            
            NSDictionary * parameters = @{@"_csrf_token": jsonObject[@"token"], @"_username":self.usernameTextField.text, @"_password":self.passwordTextField.text};
            
            // configuration de cette route je pense
            [manager POST:[NSString stringWithFormat:@"%@/login_check", _env] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"html %@", responseObject);
                //jsonObject[@"token"];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"login error : %@", error);
            }];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"token error : %@", error);
        }];
        
    }
    else
    {
        NSLog(@"alert mdp && username");
    }
    
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
