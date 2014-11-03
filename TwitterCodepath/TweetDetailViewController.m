//
//  TweetDetailViewController.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 11/2/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"
#import "Tweet.h"
#import "User.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileimage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetTextAtTop;

@end

@implementation TweetDetailViewController
- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet.tweetID completion:^(NSDictionary *response, NSError *error) {
        if (response != nil) {
            NSLog(@"Successfully !");
        }
    }];

}
- (IBAction)onFavourite:(id)sender {
    
    [[TwitterClient sharedInstance] favourite:self.tweet.tweetID completion:^(NSError *error) {
        if (error == nil) {
           NSLog(@"Success!");
          
        }
    }];
   

}
- (IBAction)onReply:(id)sender {
    
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    vc.replyHandle = [NSString stringWithFormat:@"@%@ ",self.tweet.sender.sreenname];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.profileimage setImageWithURL:[NSURL URLWithString:self.tweet.profileimageurl]];

    self.contentLabel.text = self.tweet.tweettext;
    self.nameLabel.text = self.tweet.name;
    self.handleLabel.text =self.tweet.twitterhandle;
    self.title = @"Tweet Detail";

    
    if (self.tweet.sender != nil) {
        self.retweetTextAtTop.text = [NSString stringWithFormat:@"%@ retweeted", self.tweet.sender.name];
        
        [self.retweetTextAtTop setHidden:NO];
        [self.retweetTextAtTop setHidden:NO];
    } else {
        [self.retweetTextAtTop setHidden:YES];
        [self.retweetTextAtTop setHidden:YES];
    }
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
