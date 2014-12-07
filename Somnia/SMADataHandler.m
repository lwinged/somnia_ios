//
//  SMADataHandler.m
//  Somnia
//
//  Created by flav on 26/10/2014.
//  Copyright (c) 2014 flav. All rights reserved.
//

#import "SMADataHandler.h"
#import "SMAGlobal.h"

@implementation SMADataHandler


- (id)init
{

    self = [super init];
    
    if (self) {

        self.clientID = @"1_gsghm5kf52goo00cowgsksk8so0wwss84w4ko4g4gs0kw88wc";
        self.clientSecret = @"5p5efae5rocgk88okk84c00ccwk4k404w44sk4wo804w8osk44";
        self.oauthClient = [AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:_env] clientID:self.clientID secret:self.clientSecret];
        self.manager = [AFHTTPRequestOperationManager manager];
        self.status = NONE;
    }
    
    return self;
}

- (void)getPlatformAccessToken
{
    NSURL *getTokenURL = [NSURL URLWithString:[_env stringByAppendingString:@"/oauth/v2/token"]];
    
    NSDictionary *params = @{@"client_id" : self.clientID, @"client_secret" : self.clientSecret, @"grant_type" : @"client_credentials"};
    
    [self.oauthClient authenticateUsingOAuthWithURLString:[getTokenURL absoluteString] parameters:params success:^(AFOAuthCredential *credential) {
        
        [AFOAuthCredential storeCredential:credential withIdentifier:self.oauthClient.serviceProviderIdentifier];
        
        self.status = SIGNUP;
        
    } failure:^(NSError *error) {
        
        self.status = ERRORTOKEN;
        
    }];
}


- (void) signUpUser:(NSString *) email :(NSString *) login :(NSString *) password
{
    AFOAuthCredential* credential = [AFOAuthCredential retrieveCredentialWithIdentifier:self.oauthClient.serviceProviderIdentifier];
    
        NSDictionary *params = @{@"access_token" : credential.accessToken, @"email" : email, @"username" : login, @"password" : password};
        
        [self.manager POST:[_env stringByAppendingString:@"/api/v1/registerNewUser"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
            if (responseObject[@"success"])
                self.status = SUCCESSREGISTER;
            else
                self.status = ERRORREGIRSTER;

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            self.status = ERRORTOKEN;
            
        }];
    
}

- (void)getUserAccessToken:(NSString *) login :(NSString *) password
{
    NSURL *getTokenURL = [NSURL URLWithString:[_env stringByAppendingString:@"/oauth/v2/token"]];
    
    NSDictionary *params = @{@"client_id" : self.clientID, @"client_secret" : self.clientSecret, @"grant_type" : @"password", @"username" : login, @"password" : password};
    
    [self.oauthClient authenticateUsingOAuthWithURLString:[getTokenURL absoluteString] parameters:params success:^(AFOAuthCredential *credential) {
        
            [AFOAuthCredential storeCredential:credential withIdentifier:self.oauthClient.serviceProviderIdentifier];
            self.status = LOGIN;
        
    } failure:^(NSError *error) {
        
        if (error.userInfo[@"_kCFStreamErrorCodeKey"])
            self.status = ERRORTOKEN;
        else
            self.status = ERRORLOGIN;
        
        
    }];
}


@end
