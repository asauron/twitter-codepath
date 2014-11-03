//
//  Tweet.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "Tweet.h"
#import <NSDate+TimeAgo.h>

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
    
        //self.createdAt = [formatter dateFromString:createdAtString];
        
       // NSDateFormatter *datefformat = [[NSDateFormatter alloc] init];
        //[datefformat setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
        NSDate *tweetDate = [formatter dateFromString:createdAtString];
        self.timestamp = [tweetDate timeAgo];
    
       
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.retweetCount = dictionary[@"retweet_count"];
        self.favoriteCount = dictionary[@"favorite_count"];

        if ([dictionary objectForKey:@"retweeted_status"] != nil) {
            self.sender = [[User alloc] initWithDictionary:dictionary[@"retweeted_status"][@"user"]];
            self.isRetweet = true;
        } else {
            self.sender = nil;
        }
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
