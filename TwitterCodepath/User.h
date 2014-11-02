//
//  User.h
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSDictionary *dictionary;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sreenname;
@property (nonatomic,strong) NSString *profileImageUrl;
@property (nonatomic,strong) NSString *tagline;
@property (nonatomic,assign) NSInteger tweetcount;
@property (nonatomic,assign) NSInteger followingcount;
@property (nonatomic,assign) NSInteger followercount;
@property (nonatomic, strong)  NSString *profileimageurl;
@property (nonatomic, strong)  NSString *backgroundImageURL;

+ (User *)currentUser;
+(void)setCurrentUser:(User *)currentUser;

-(id) initWithDictionary:(NSDictionary *) dictionary;


@end
