//
//  TwitterClient.h
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *) sharedInstance;
@end
