//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Mike North on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TimelineVC.h"

@interface TweetDetailViewController ()
@property (strong) Tweet  *tweet;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorScreenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
- (IBAction)tweetFavorited:(id)sender;
- (IBAction)tweetRetweeted:(id)sender;
- (IBAction)tweetReplied:(id)sender;


@end

@implementation TweetDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.authorNameLabel.text = self.tweet.authorName;
    self.authorScreenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.authorHandle];
    self.tweetContentLabel.text = self.tweet.text;
    // Load the image
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.tweet.authorAvatarUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            self.authorAvatarImageView.image = [UIImage imageWithData: data];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) initWithTweet:(id)tweet
{
    TweetDetailViewController* me = [[TweetDetailViewController alloc] init];
    NSLog(@"Initialized with tweet");
    me.tweet = tweet;
    return me;
}

- (IBAction)tweetFavorited:(id)sender {
    UINavigationController *nc = self.navigationController;
    [nc popViewControllerAnimated:YES];
    
    TimelineVC *timelineVc = (TimelineVC*)[nc topViewController];
    
    [[TwitterClient instance] favorite:self.tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
        [timelineVc reload];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to favorite :(");
    }];
}

- (IBAction)tweetRetweeted:(id)sender {
    UINavigationController *nc = self.navigationController;
    [nc popViewControllerAnimated:YES];
    
    TimelineVC *timelineVc = (TimelineVC*)[nc topViewController];
    
    [[TwitterClient instance] retweet:self.tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
        [timelineVc reload];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to favorite :(");
    }];
}

- (IBAction)tweetReplied:(id)sender {
    UINavigationController *nc = self.navigationController;
    [nc popViewControllerAnimated:YES];
    
    TimelineVC *timelineVc = (TimelineVC*)[nc topViewController];
    
    [[TwitterClient instance] retweet:self.tweet.id success:^(AFHTTPRequestOperation *operation, id response) {
        [timelineVc reload];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to favorite :(");
    }];
}

@end
