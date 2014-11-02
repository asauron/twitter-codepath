//
//  Tweet.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet


-(id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if(self){
        self.tweetID               = dictionary[@"id"];
        self.tweettext             = dictionary[@"text"];
        self.profileimageurl      = dictionary[@"user"][@"profile_image_url"];
        self.twitterhandle         = dictionary[@"user"][@"screen_name"];
        self.name                   = dictionary[@"user"][@"name"];
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ssZ y";
        
        self.createdAt = [formatter dateFromString:createdAtString];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
    }
    
    return self;
    
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array
{
    NSLog(@"Starting tweetsWithArray");
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
