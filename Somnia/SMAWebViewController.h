//
//  SMAViewController.h
//  Somnia
//
//  Created by flav on 22/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    WebViewController - control embedded web view
 */

@interface SMAWebViewController : UIViewController <UIWebViewDelegate>


/**
    Embedded Webview
 */

@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**
    url to request in order to load page
 */
@property (strong, nonatomic) NSString * url;


/**
 hide the status bar
 */

- (BOOL)prefersStatusBarHidden;

/**
 when the request starts to load, we check if a logout request is sent
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end
