//
//  Tweet.h
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject
-(id) initWithDictionary:(NSDictionary *) dictionary;

@property (nonatomic, strong) NSString *tweetID;
@property (nonatomic, strong) NSString *tweettext;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *profileimageurl;
@property (nonatomic, strong) NSString *twitterhandle;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *relative_timestamp;
@property (nonatomic, strong) NSNumber *favoritecount;
@property (nonatomic, strong) NSNumber *retweetcount;
@property (strong,nonatomic) User *user;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
