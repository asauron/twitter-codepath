//
//  AppDelegate.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/30/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#include "TweetsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    UIViewController *vc = nil;
    User *user = [User currentUser];
    if (user != nil) {
        NSLog(@"Welcome to the tweets view page %@", user.name);
        //self.window.rootViewController = [[TweetsViewController alloc] init];
        vc=[[TweetsViewController alloc] init];
    } else {
        NSLog(@"Not logged in");
        vc = [[LoginViewController alloc] init];
    }
    
    //self.window.rootViewController = [[LoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *) application openURL:(NSURL *) url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[TwitterClient sharedInstance] openURL:url];
    
    /*[[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        NSLog(@"got access oken");
        
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        User *user = [[User alloc]initWithDictionary:responseObject];
                                        NSLog(@"current user name %@",user.name);

                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"did not get current user");
                                    }];
    } failure:^(NSError *error) {
        NSLog(@"did not get access token");

    }];*/
    return YES;
}

@end
