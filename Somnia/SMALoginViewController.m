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
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    
    //fill fields if not logout
    
    self.usernameTextField.text = [[UICKeyChainStore keyChainStore] stringForKey:@"username"];
    self.passwordTextField.text = [[UICKeyChainStore keyChainStore] stringForKey:@"password"];
    
    
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(65, 171, 107);

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : Rgb2UIColor(65, 171, 107)};
    
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
 start login request to web server when login button is pressed
 */
- (IBAction)loginAction:(id)sender
{    
    
    if (![self.usernameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""])
    {
        
        av = [UIActivityIndicatorView new];
        av.color = Rgb2UIColor(65, 171, 107);
        
        button = (UIButton *)sender;
        [av setCenter:button.center];
        button.hidden = YES;
        [self.view addSubview:av];
        [av startAnimating];
     
        [self.dataHandler getUserAccessToken:self.usernameTextField.text :self.passwordTextField.text];
        
    }
    else
        [SMAFormHelper showAlert:NSLocalizedString(@"Error Field",nil) :NSLocalizedString(@"Please enter your username and password",nil)];
    
}



- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch (self.dataHandler.status) {
        case LOGIN:
        {
            
            UICKeyChainStore *store = [UICKeyChainStore keyChainStore];
            [store setString:self.usernameTextField.text forKey:@"username"];
            [store setString:self.passwordTextField.text forKey:@"password"];
            [store synchronize];


            SMATabBarController * tabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarcontroller"];
            tabbar.username = self.usernameTextField.text;
            
            AFOAuthCredential* credential = [AFOAuthCredential retrieveCredentialWithIdentifier:self.dataHandler.oauthClient.serviceProviderIdentifier];
            tabbar.accessToken = credential.accessToken;
            [self presentViewController:tabbar animated:YES completion: nil];

            break;
        }
        case ERRORTOKEN:
            [SMAFormHelper showAlertAndStopAnimation:NSLocalizedString(@"Error Token", nil):NSLocalizedString(@"No network connection", nil) :av :button];
            break;
        case ERRORLOGIN:
            [SMAFormHelper showAlertAndStopAnimation:NSLocalizedString(@"Error authentication",nil) :NSLocalizedString(@"Invalid username or password",nil) :av :button];
            break;
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

@end
