//
//  SMATabBarController.m
//  Somnia
//
//  Created by flav on 22/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMATabBarController.h"

#import "SMAWebViewController.h"
#import "SMAGlobal.h"

@interface SMATabBarController ()

@end

@implementation SMATabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
    When view did load, 3 webviews load their pages (discover, contribute, my profile)
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.tintColor = Rgb2UIColor(65, 171, 107);
    
    SMAWebViewController * webViewController = self.viewControllers[0];
    [webViewController setUrl:[NSString stringWithFormat:@"%@/api/v1/connectByAccessToken?&access_token=%@&target=Somnia_Discover_Goals", _env, self.accessToken]];
    UITabBarItem * item = self.tabBar.items[0];
    item.title = NSLocalizedString(@"Discover", nil);
    item.image = [UIImage imageNamed:@"discover.png"];

    
    
    webViewController = self.viewControllers[1];
    [webViewController setUrl:[NSString stringWithFormat:@"%@/contribute", _env]];
    item = self.tabBar.items[1];
    item.title =  NSLocalizedString(@"Contribute", nil);
    item.image = [UIImage imageNamed:@"contribute.png"];

    
    webViewController = self.viewControllers[2];
    [webViewController setUrl:[NSString stringWithFormat:@"%@/user/%@", _env, self.username]];
    item = self.tabBar.items[2];
    item.title = NSLocalizedString(@"My profile", nil);
    item.image = [UIImage imageNamed:@"myprofile.png"];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
