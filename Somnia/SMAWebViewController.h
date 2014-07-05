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


@end
