//
//  TwitterClient.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "TwitterClient.h"
#import <NSDictionary+BDBOAuth1Manager.h>

NSString * const kTwitterConsumerKey = @"hoat7TYGBTfVq821QCPdkPiEN";
NSString * const kTwitterConsumerSecret = @"jg8WOTAdDPnij57Tybrnl9V97kPzBjbZ7xuDQql0pldTyTcwQ3";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";



@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient 

+ (TwitterClient *) sharedInstance{
    static TwitterClient *instance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      if(instance == nil){
          instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
      }
    });
    return instance;
    
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"got the request token!");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        NSLog(@"failed to get the request token!");
        self.loginCompletion(nil, error);
    }];
    
}

- (void)openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        NSLog(@"got access token");
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
           // NSLog(@"current user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"user object: %@", user.name);
         //   [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to get current user");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token");
    }];
    
}

/*- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error loading home_timeline");
        completion(nil, error);
    }];
}*/

@end