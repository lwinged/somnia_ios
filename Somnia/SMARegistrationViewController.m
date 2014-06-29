//
//  SMARegistrationViewController.m
//  Somnia
//
//  Created by flav on 28/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMARegistrationViewController.h"
#import "AFHTTPSessionManager.h"
#import "SMAGlobal.h"


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
    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""] && ![self.emailTextField.text isEqualToString:@""] && [self validateEmail:self.emailTextField.text])
    {
        
        UIActivityIndicatorView  *av = [UIActivityIndicatorView new];
        av.color = Rgb2UIColor(65, 171, 107);
        
        UIButton * button = (UIButton *)sender;
        [av setCenter:button.center];
        button.hidden = YES;
        [self.view addSubview:av];
        [av startAnimating];
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
        [manager GET:[NSString stringWithFormat:@"%@/token/registration", _env] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary *jsonObject = responseObject;
            NSLog(@"%@",jsonObject);
            
            NSDictionary * parameters = @{@"fos_user_registration_form[_token]": jsonObject[@"token"], @"fos_user_registration_form[username]":self.usernameTextField.text, @"fos_user_registration_form[plainPassword][first]":self.passwordTextField.text,
                @"fos_user_registration_form[plainPassword][second]":self.passwordTextField.text,
                @"fos_user_registration_form[email]":self.emailTextField.text};
            
            AFHTTPResponseSerializer *requestSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager setResponseSerializer:requestSerializer];
            
            [manager POST:[NSString stringWithFormat:@"%@/signup/", _env] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

                NSLog(@"%@", html);
                //Logged

                if ([html rangeOfString:@"created successfully" options:NSCaseInsensitiveSearch].length
                    > 0)
                {
                    [av stopAnimating];
                    button.hidden = NO;
                    [self showAlert:@"Registration success" :@"Now you can log in"];
                    
                }
                else
                {
                    [self showAlert:@"Error Registration" :@"Username already exist"];
                    [av stopAnimating];
                    button.hidden = NO;
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [self showAlert:@"Error Registration" :@"Username already exist"];
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
        [self showAlert:@"Error Field" :@"Please, fill in correctly all the fields"];
    
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


-(BOOL) validateEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    if (regExMatches == 0) {
        return NO;
    }
    else
        return YES;
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
