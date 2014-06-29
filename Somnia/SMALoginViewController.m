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
#import "SMATabBarController.h"

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
        
        UIActivityIndicatorView  *av = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        av.frame=CGRectMake(145, 160, 25, 25);
        UIButton * button = (UIButton *)sender;
        [av setCenter:button.center];
        button.hidden = YES;
        [self.view addSubview:av];
        [av startAnimating];
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
        [manager GET:[NSString stringWithFormat:@"%@/token/authenticate", _env] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary *jsonObject = responseObject;
            
            NSDictionary * parameters = @{@"_csrf_token": jsonObject[@"token"], @"_username":self.usernameTextField.text, @"_password":self.passwordTextField.text};
            
            AFHTTPResponseSerializer *requestSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager setResponseSerializer:requestSerializer];
            
            [manager POST:[NSString stringWithFormat:@"%@/login_check", _env] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

                if ([html rangeOfString:@"Invalid" options:NSCaseInsensitiveSearch].length
                    > 0)
                {
                    [self showAlert:@"Error authentication" :@"Invalid username or password"];
                    [av stopAnimating];
                    button.hidden = NO;
                }
                else
                {
                    SMATabBarController * tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
                    tabbar.username = self.usernameTextField.text;
                    [self presentViewController:tabbar animated:YES completion: nil];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
             
                [self showAlert:@"Error login check" :@"No network connection"];
                [av stopAnimating];
                button.hidden = NO;
            }];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self showAlert:@"Error Token" :@"No network connection"];
            [av stopAnimating];
            button.hidden = NO;

        }];
        
    }
    else
        [self showAlert:@"Error Field" :@"Please enter your username and password"];
    
}

- (void) showAlert:(NSString *) title :(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end