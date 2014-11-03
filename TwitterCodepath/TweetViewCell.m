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

@interface TweetViewCell()





@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *FavButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIButton *replyButton;

@property (weak, nonatomic) IBOutlet UILabel *handleLabel;



@end

@implementation TweetViewCell
- (IBAction)onReply:(id)sender {
}

- (IBAction)onFavorite:(id)sender {
}

- (IBAction)onRetweet:(id)sender {
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
    //    self.timestampLabel.text = tweet.truncatedCreatedAt;
    self.tweetLabel.text = tweet.tweettext;
}




@end
