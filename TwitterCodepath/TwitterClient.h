//
//  TwitterClient.h
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *) sharedInstance;
- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void) post:(User *)user withText:(NSString *)text completion:(void (^)(NSError *error)) completion;
- (void) favourite:(NSString *)tweetId completion:(void (^)(NSError *error))completion;
- (void) retweet:(NSString *)tweetId completion:(void (^)(NSDictionary *response, NSError *error))completion;
@end
