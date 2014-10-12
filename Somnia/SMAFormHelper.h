//
//  SMAFormHelper.h
//  Somnia
//
//  Created by flav on 12/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMAFormHelper : NSObject

/**
 show alert message (pop up)
 */
+ (void) showAlert:(NSString *) title :(NSString *) message;


/**
 email validator
 */
+(BOOL) validateEmail:(NSString*) emailString;


@end
