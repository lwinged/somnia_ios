//
//  SMADataHandler.m
//  Somnia
//
//  Created by flav on 26/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMADataHandler.h"
#import "AFOAuth2Client.h"
#import "SMAGlobal.h"

@implementation SMADataHandler

static NSString* clientID = @"1_gsghm5kf52goo00cowgsksk8so0wwss84w4ko4g4gs0kw88wc";
static NSString* clientSecret = @"5p5efae5rocgk88okk84c00ccwk4k404w44sk4wo804w8osk44";
static AFOAuth2Client *oauthClient = nil;


+ (void)initialize
{

    NSURL *url = [NSURL URLWithString:_env];
    oauthClient = [AFOAuth2Client clientWithBaseURL:url clientID:clientID secret:clientSecret];
    
}

+ (void)getPlatformAccessToken
{
    NSURL *getTokenURL = [NSURL URLWithString:[_env stringByAppendingString:@"/oauth/v2/token"]];
    
    NSDictionary *params = @{@"client_id" : clientID, @"client_secret" : clientSecret, @"grant_type" : @"client_credentials"};
    
    [oauthClient authenticateUsingOAuthWithURLString:[getTokenURL absoluteString] parameters:params success:^(AFOAuthCredential *credential) {
        
        NSLog(@"AccessToken : %@", credential);
        [AFOAuthCredential storeCredential:credential withIdentifier:oauthClient.serviceProviderIdentifier];
    
        //test
        [self signUpUser:@"tutu" :@"tutu" :credential.accessToken];
        
    } failure:^(NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}

+ (void)getUserAccessToken:(NSString *) login :(NSString *) password
{
    NSLog(@"getUserAccessToken: %@, %@, %@, %@", login, password,clientID, clientSecret);
    NSURL *getTokenURL = [NSURL URLWithString:[_env stringByAppendingString:@"/oauth/v2/token"]];
    
    NSDictionary *params = @{@"client_id" : clientID, @"client_secret" : clientSecret, @"grant_type" : @"password", @"username" : login, @"password" : password};
    
    [oauthClient authenticateUsingOAuthWithURLString:[getTokenURL absoluteString] parameters:params success:^(AFOAuthCredential *credential) {
        
        NSLog(@"AccessToken : %@", credential.accessToken);
        [AFOAuthCredential storeCredential:credential withIdentifier:oauthClient.serviceProviderIdentifier];
        
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}

+ (void) signUpUser:(NSString *) login :(NSString *) password :(NSString *)accessToken
{
    
    NSDictionary *params = @{@"access_token" : accessToken, @"email" : login, @"password" : password};
    
    
    [oauthClient POST:[_env stringByAppendingString:@"/api/v1/registerNewUser"] parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
    
        NSLog(@"AccessToken register -> : %@", responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);

    }];
    
    
}

@end
