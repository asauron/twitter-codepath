//
//  LoginViewController.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 10/30/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)loginButton:(id)sender {

    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];

    [[TwitterClient sharedInstance ] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
         NSLog(@"got the request token");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",requestToken.token]];
        [[UIApplication sharedApplication]openURL:authURL];
        
     } failure:^(NSError *error) {
         NSLog(@"didnt get the token");
     }];
}
    

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
