//
//  SMAViewController.h
//  Somnia
//
//  Created by flav on 22/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAWebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString * url;

@end
