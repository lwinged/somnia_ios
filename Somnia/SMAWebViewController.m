//
//  SMAViewController.m
//  Somnia
//
//  Created by flav on 22/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMAWebViewController.h"
#import "UICKeyChainStore.h"

@interface SMAWebViewController ()

@end

@implementation SMAWebViewController


/**
when view did load the webview starts the request (see url)
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.webView.delegate = self;
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0,0,self.tabBarController.tabBar.frame.size.height,0);

    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

/**
    when the request starts to load, we check if a logout request is sent
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasSuffix:@"logout"])
    {
        //erase login and password

        UICKeyChainStore *store = [UICKeyChainStore keyChainStore];
        [store removeItemForKey:@"username"];
        [store removeItemForKey:@"password"];
        [store synchronize];

        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"navigationcontroller"] animated:YES completion: nil];

    }
    return YES;
}

/**
 hide the status bar
 */

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
