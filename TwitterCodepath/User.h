//
//  User.h
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/31/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sreenname;
@property (nonatomic,strong) NSString *profileImageUrl;
@property (nonatomic,strong) NSString *tagline;

-(id) initWithDictionary:(NSDictionary *) dictionary;


@end
