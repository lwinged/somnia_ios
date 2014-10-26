//
//  SMADataHandler.h
//  Somnia
//
//  Created by flav on 26/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMADataHandler : NSObject

+ (void) getPlatformAccessToken;
+ (void) getUserAccessToken:(NSString *)login :(NSString *)password;

+ (void) signUpUser:(NSString *) login :(NSString *) password :(NSString *)accessToken;


@end
