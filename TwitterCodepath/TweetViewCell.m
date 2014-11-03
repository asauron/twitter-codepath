//
//  TweetViewCell.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 11/2/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "TweetViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"
@interface TweetViewCell()





@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *FavButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) UIViewController *parentVC;

@property (weak, nonatomic) IBOutlet UILabel *retweetedLabek;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;

@property (weak, nonatomic) IBOutlet UILabel *handleLabel;



@end

@implementation TweetViewCell
- (IBAction)onReply:(id)sender {
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    vc.replyHandle = [NSString stringWithFormat:@"@%@ ",self.tweet.sender.name];
     [self.parentVC.navigationController pushViewController:vc animated:YES];

    
}

- (IBAction)onFavorite:(id)sender {
    [[TwitterClient sharedInstance] favourite:self.tweet.tweetID completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Success!");
            
        }
    }];
    
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet.tweetID completion:^(NSDictionary *response, NSError *error) {
        if (response != nil) {
            NSLog(@"Successfully retweeted!");
        }
    }];
}



- (void)awakeFromNib {
    // Initialization code
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
    
    self.profileImageView.layer.cornerRadius = 3;
    self.profileImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.profileimageurl]];
    self.nameLabel.text = tweet.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.twitterhandle];
    self.timeLabel.text = tweet.timestamp;
    self.tweetLabel.text = tweet.tweettext;
    if (self.tweet.sender != nil) {
        self.retweetedLabek.text = [NSString stringWithFormat:@"%@ retweeted", self.tweet.sender.name];
        [self.retweetedLabek setHidden:NO];
    } else {
        [self.retweetedLabek setHidden:YES];
    }

}




@end
