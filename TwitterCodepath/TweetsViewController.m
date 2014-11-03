//
//  TweetsViewController.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 11/2/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetViewCell.h"
#import "TweetDetailViewController.h"

#import "UIImageView+AFNetworking.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (nonatomic, strong) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onCompose:)];
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for(Tweet *tweet in tweets){
            NSLog(@"test %@", tweet.tweettext);
        }
        self.tweets = tweets;
        NSLog(@"Loaded %lu tweets!", (unsigned long)tweets.count);
        [self.tweetsTableView reloadData];

    }];
    self.tweetsTableView.delegate = self;
    self.tweetsTableView.dataSource = self;
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tweetsTableView insertSubview:self.refreshControl atIndex:0];
    
    UINib *tweetNib = [UINib nibWithNibName:@"TweetViewCell" bundle:nil];
    [self.tweetsTableView registerNib:tweetNib forCellReuseIdentifier:@"TweetViewCell"];
   
     [self.refreshControl.superview sendSubviewToBack:self.refreshControl];
}


- (void) onRefresh {
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for(Tweet *tweet in tweets){
            NSLog(@"test %@", tweet.tweettext);
        }
        self.tweets = tweets;
        NSLog(@"Loaded %lu tweets!", (unsigned long)tweets.count);
        [self.tweetsTableView reloadData];
        
    }];
     [self.refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogout:(id)sender {
    NSLog(@"logging out");
    [User logOut];
}

- (IBAction)onCompose:(id)sender {
    NSLog(@"composing ");
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    
    NSString *text = tweet.tweettext;
    UIFont *fontText = [UIFont systemFontOfSize:15.0];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(225, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontText}
                                     context:nil];
    
    CGFloat heightOffset = 120;
    return rect.size.height + heightOffset;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetViewCell" forIndexPath:indexPath];
    cell.tweet = self.tweets[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
    
    vc.title = @"Tweet";
    
    vc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
