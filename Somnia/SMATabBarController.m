//
//  SMATabBarController.m
//  Somnia
//
//  Created by flav on 22/06/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMATabBarController.h"

#import "SMAWebViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SMAWebViewController * webViewController = self.viewControllers[0];
    [webViewController setUrl:@"http://vm-0.lwinged.kd.io/Somnia/web/app.php/discover/goals"];

    webViewController = self.viewControllers[1];
    [webViewController setUrl:@"http://vm-0.lwinged.kd.io/Somnia/web/app.php/contribute"];

    
    webViewController = self.viewControllers[2];
    [webViewController setUrl:@"http://vm-0.lwinged.kd.io/Somnia/web/app.php/login"];
    
    webViewController = self.viewControllers[3];
    [webViewController setUrl:@"http://vm-0.lwinged.kd.io/Somnia/web/app.php/signup/"];
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
