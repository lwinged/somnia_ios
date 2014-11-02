//
//  SMADataHandler.h
//  Somnia
//
//  Created by flav on 26/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth2Client.h"

@interface SMADataHandler : NSObject

typedef enum actionCode
{
    NONE = 0,
    SIGNUP,
    LOGGED,
    ERRORTOKEN,
    ERRORLOGGIN,
    ERRORREGIRSTER,
    SUCCESSREGISTER,
} eActionCode;

@property (nonatomic, strong) NSString* clientID;
@property (nonatomic, strong) NSString* clientSecret;
@property (nonatomic, strong) AFOAuth2Client * oauthClient;
@property (nonatomic, strong) AFHTTPRequestOperationManager * manager;
@property (nonatomic, assign) eActionCode status;

- (void) getPlatformAccessToken;
- (void) getUserAccessToken:(NSString *)login :(NSString *)password;
- (void) signUpUser:(NSString *) email :(NSString *) login :(NSString *) password;

@end
