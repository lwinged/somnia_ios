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
#import "SMAFormHelper.h"

#import "UICKeyChainStore.h"


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
    
    
    //fill fields if not logout
    
    self.usernameTextField.text = [[UICKeyChainStore keyChainStore] stringForKey:@"username"];
    self.passwordTextField.text = [[UICKeyChainStore keyChainStore] stringForKey:@"password"];
    
    
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(65, 171, 107);

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : Rgb2UIColor(65, 171, 107)};
    
}


/**
 hide keybord when return button is pressed
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/**
 start login request to web server when login button is pressed
 */
- (IBAction)loginAction:(id)sender
{    
    
    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""])
    {
        
        UIActivityIndicatorView  *av = [UIActivityIndicatorView new];
        av.color = Rgb2UIColor(65, 171, 107);
        
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
                    [SMAFormHelper showAlert:NSLocalizedString(@"Error authentication",nil) :NSLocalizedString(@"Invalid username or password",nil)];
                    [av stopAnimating];
                    button.hidden = NO;
                }
                else
                {
                    
                    UICKeyChainStore *store = [UICKeyChainStore keyChainStore];
                    [store setString:self.usernameTextField.text forKey:@"username"];
                    [store setString:self.passwordTextField.text forKey:@"password"];
                    [store synchronize];
                    
                    
                    SMATabBarController * tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
                    tabbar.username = self.usernameTextField.text;
                    [self presentViewController:tabbar animated:YES completion: nil];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
             
                [SMAFormHelper showAlert:NSLocalizedString(@"Error login check",nil) :NSLocalizedString(@"No network connection",nil)];
                [av stopAnimating];
                button.hidden = NO;
            }];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [SMAFormHelper showAlert:NSLocalizedString(@"Error Token",nil) :NSLocalizedString(@"No network connection",nil)];
            [av stopAnimating];
            button.hidden = NO;

        }];
        
    }
    else
        [SMAFormHelper showAlert:NSLocalizedString(@"Error Field",nil) :NSLocalizedString(@"Please enter your username and password",nil)];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
