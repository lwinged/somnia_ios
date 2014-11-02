//
//  SMAFormHelper.m
//  Somnia
//
//  Created by flav on 12/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMAFormHelper.h"

@implementation SMAFormHelper



/**
 show alert message (pop up)
 */
+ (void) showAlert:(NSString *) title :(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


/**
 email validator
 */
+ (BOOL) validateEmail:(NSString*) emailString
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


@end
