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

@end
