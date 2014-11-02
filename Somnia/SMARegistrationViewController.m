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
#import "SMAFormHelper.h"


@interface SMARegistrationViewController ()

@end

@implementation SMARegistrationViewController

static UIActivityIndicatorView  *av;
static UIButton * button;

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
    
    self.dataHandler = [SMADataHandler new];
    
    [self.dataHandler addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld context:nil];
    
}
/**
hide keybord when return button is pressed
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/**
 start registration request to web server when registration button is pressed
 */
- (IBAction)registerAction:(id)sender
{
    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""] && ![self.emailTextField.text isEqualToString:@""] && [SMAFormHelper validateEmail:self.emailTextField.text])
    {
        
        av = [UIActivityIndicatorView new];
        av.color = Rgb2UIColor(65, 171, 107);
        
        button = (UIButton *)sender;
        [av setCenter:button.center];
        button.hidden = YES;
        [self.view addSubview:av];
        [av startAnimating];
        
        [self.dataHandler signUpUser:self.emailTextField.text :self.usernameTextField.text :self.passwordTextField.text];
        
    }
    else
        [SMAFormHelper showAlert:NSLocalizedString(@"Error Field", nil) :NSLocalizedString(@"Please, fill in correctly all the fields", nil)];
    
    
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch (self.dataHandler.status) {
        case CANSIGNUP:
            [self.dataHandler signUpUser:self.emailTextField.text :self.usernameTextField.text :self.passwordTextField.text];
            break;
        case SUCCESSREGISTER:
        {
            [SMAFormHelper showAlert:NSLocalizedString(@"Registration success",nil) :NSLocalizedString(@"Now you can log in",nil)];
            [av stopAnimating];
            button.hidden = NO;
            break;
        }
        case ERRORTOKEN:
        {
           [SMAFormHelper showAlert:NSLocalizedString(@"Error Token", nil):NSLocalizedString(@"No network connection", nil)];
           [av stopAnimating];
            button.hidden = NO;
            break;
        }
        case ERRORREGIRSTER:
        {
            [SMAFormHelper showAlert:NSLocalizedString(@"Error Registration",nil) :NSLocalizedString(@"Username already exist",nil)];
            [av stopAnimating];
            button.hidden = NO;
            break;
        }
            
        default:
            break;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.dataHandler removeObserver:self forKeyPath:@"status"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (IBAction)registerAction:(id)sender
//{
//    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""] && ![self.emailTextField.text isEqualToString:@""] && [SMAFormHelper validateEmail:self.emailTextField.text])
//    {
//        
//        UIActivityIndicatorView  *av = [UIActivityIndicatorView new];
//        av.color = Rgb2UIColor(65, 171, 107);
//        
//        UIButton * button = (UIButton *)sender;
//        [av setCenter:button.center];
//        button.hidden = YES;
//        [self.view addSubview:av];
//        [av startAnimating];
//        
//        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//        
//        [manager GET:[NSString stringWithFormat:@"%@/token/registration", _env] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSDictionary *jsonObject = responseObject;
//            
//            NSDictionary * parameters = @{@"fos_user_registration_form[_token]": jsonObject[@"token"], @"fos_user_registration_form[username]":self.usernameTextField.text, @"fos_user_registration_form[plainPassword][first]":self.passwordTextField.text,
//                                          @"fos_user_registration_form[plainPassword][second]":self.passwordTextField.text,
//                                          @"fos_user_registration_form[email]":self.emailTextField.text};
//            
//            AFHTTPResponseSerializer *requestSerializer = [AFHTTPResponseSerializer serializer];
//            
//            [manager setResponseSerializer:requestSerializer];
//            
//            [manager POST:[NSString stringWithFormat:@"%@/signup/", _env] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//                
//                NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                
//                NSLog(@"%@", html);
//                //Logged
//                
//                if ([html rangeOfString:@"created successfully" options:NSCaseInsensitiveSearch].length
//                    > 0)
//                {
//                    [av stopAnimating];
//                    button.hidden = NO;
//                    [SMAFormHelper showAlert:NSLocalizedString(@"Registration success",nil) :NSLocalizedString(@"Now you can log in",nil)];
//                    
//                }
//                else
//                {
//                    [SMAFormHelper showAlert:NSLocalizedString(@"Error Registration",nil) :NSLocalizedString(@"Username already exist",nil)];
//                    [av stopAnimating];
//                    button.hidden = NO;
//                }
//                
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                
//                [SMAFormHelper showAlert:NSLocalizedString(@"Error Registration",nil) :NSLocalizedString(@"Username already exist",nil)];
//                [av stopAnimating];
//                button.hidden = NO;
//            }];
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            
//            [SMAFormHelper showAlert:NSLocalizedString(@"Error Token", nil):NSLocalizedString(@"No network connection", nil)];
//            [av stopAnimating];
//            button.hidden = NO;
//            
//        }];
//        
//        
//    }
//    else
//        [SMAFormHelper showAlert:NSLocalizedString(@"Error Field", nil) :NSLocalizedString(@"Please, fill in correctly all the fields", nil)];
//    
//    
//}



@end
