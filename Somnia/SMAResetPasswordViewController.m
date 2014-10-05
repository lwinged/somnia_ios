//
//  SMAResetPasswordViewController.m
//  Somnia
//
//  Created by flav on 05/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMAResetPasswordViewController.h"
#import "AFHTTPSessionManager.h"
#import "SMAGlobal.h"

@interface SMAResetPasswordViewController ()

@end

@implementation SMAResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)resetPasswordAction:(id)sender {
    
    // a revoir
    
    if (![self.emailTextField.text isEqualToString:@""] && [self validateEmail:self.emailTextField.text])
    {
        
        UIActivityIndicatorView  *av = [UIActivityIndicatorView new];
        av.color = Rgb2UIColor(65, 171, 107);
        
        UIButton * button = (UIButton *)sender;
        [av setCenter:button.center];
        button.hidden = YES;
        [self.view addSubview:av];
        [av startAnimating];
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
            NSDictionary * parameters = @{@"username": self.emailTextField.text};
        
            AFHTTPResponseSerializer *requestSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager setResponseSerializer:requestSerializer];
            
            [manager POST:[NSString stringWithFormat:@"%@/resetting/send-email", _env] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                NSLog(@"%@", html);
                //Logged
                
                if ([html rangeOfString:@"created successfully" options:NSCaseInsensitiveSearch].length
                    > 0)
                {
                    [av stopAnimating];
                    button.hidden = NO;
                    [self showAlert:NSLocalizedString(@"Resetting password success",nil) :NSLocalizedString(@"Now you can check your emails",nil)];
                    
                }
                else
                {
                    [self showAlert:NSLocalizedString(@"Error Resetting Password",nil) :NSLocalizedString(@"Email address doesn't exist",nil)];
                    [av stopAnimating];
                    button.hidden = NO;
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [self showAlert:NSLocalizedString(@"Error Resetting Password",nil) :NSLocalizedString(@"Email address doesn't exist",nil)];
                [av stopAnimating];
                button.hidden = NO;
            }];
    
        
        
    }
    else
        [self showAlert:NSLocalizedString(@"Error Field", nil) :NSLocalizedString(@"Please, fill in correctly all the fields", nil)];

    
}


/**
 email validator
 */
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



/**
 show alert message (pop up)
 */
- (void) showAlert:(NSString *) title :(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
