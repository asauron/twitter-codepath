//
//  User.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "User.h"
NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLoginNotification";

@interface User()

@end

@implementation User


static User *_currentUser;
NSString * const kCurrentUserKey = @"kCurrentUserKey";

-(id) initWithDictionary:(NSDictionary *) dictionary {
    self =  [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.sreenname = dictionary[@"screen_name"];
        self.tweetcount = [dictionary[@"statuses_count"] integerValue];
        self.followingcount = [dictionary[@"friends_count"] integerValue];
        self.followercount = [dictionary[@"followers_count"] integerValue];
        self.tagline = dictionary[@"description"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.backgroundImageURL = dictionary[@"profile_background_image_url"];
    }
    
    return self;
    
}


+ (User *)currentUser {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+(void)setCurrentUser:(User *)currentUser {
    _currentUser = currentUser;
    
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
