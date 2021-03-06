//
//  ComposeViewController.m
//  TwitterCodepath
//
//  Created by Abinaya Sarva on 11/2/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "ComposeViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UITextField *messageText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Compose";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet:)];
    
    User *user = [User currentUser];
    NSLog(@"current user is %@",user);
    self.nameLabel.text = user.name;
    NSLog(@"current user is %@",user.name);
    self.handleLabel.text = user.sreenname;
    NSLog(@"current user is %@",user.sreenname);
    self.messageText.text = self.replyHandle;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileimageurl]];

    self.profileImageView.layer.cornerRadius = 12;
    self.profileImageView.clipsToBounds = YES;
    
    self.messageText.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTweet:(id)sender {
    NSLog(@"Hit POST button");
    [[TwitterClient sharedInstance] post:[User currentUser] withText:self.messageText.text completion:^(NSError *error) {
        NSLog(@"tweeted");
    }];
}

- (IBAction)onCancel:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
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
