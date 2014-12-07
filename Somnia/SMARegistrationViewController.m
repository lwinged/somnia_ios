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
        
        [self.dataHandler getPlatformAccessToken];
        
    }
    else
        [SMAFormHelper showAlert:NSLocalizedString(@"Error Field", nil) :NSLocalizedString(@"Please, fill in correctly all the fields", nil)];
    
    
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch (self.dataHandler.status) {
        case SIGNUP:
            [self.dataHandler signUpUser:self.emailTextField.text :self.usernameTextField.text :self.passwordTextField.text];
            break;
        case SUCCESSREGISTER:
            [SMAFormHelper showAlertAndStopAnimation:NSLocalizedString(@"Registration success",nil) :NSLocalizedString(@"Now you can log in",nil) :av :button];
            break;
        case ERRORTOKEN:
           [SMAFormHelper showAlertAndStopAnimation:NSLocalizedString(@"Error Token", nil):NSLocalizedString(@"No network connection", nil) :av :button];
            break;
        case ERRORREGIRSTER:
            [SMAFormHelper showAlertAndStopAnimation:NSLocalizedString(@"Error Registration",nil) :NSLocalizedString(@"Username already exist",nil) :av :button];
            break;
        default:
            break;
    }
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.dataHandler addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld context:nil];
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
