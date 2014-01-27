//
//  ComposeTweetViewController.m
//  twitter
//
//  Created by Mike North on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "TimelineVC.h"
#import "TwitterClient.h"

@interface ComposeTweetViewController ()
    @property (weak, nonatomic) IBOutlet UITextField *tweetContentTextField;
    @property (strong, nonatomic) Tweet  *tweet;

    - (IBAction)sendTweetButtonPressed:(id)sender;
@end

@implementation ComposeTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithTweet:(id)tweet
{
    ComposeTweetViewController *me = [[ComposeTweetViewController alloc] init];
    me.tweet = tweet;
    return me;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendTweetButtonPressed:(id)sender {
    UINavigationController *nc = self.navigationController;
    [nc popViewControllerAnimated:YES];
    TimelineVC *timelineVc = (TimelineVC*)[nc topViewController];
    [[TwitterClient instance] composeNewTweet:self.tweetContentTextField.text success:^(AFHTTPRequestOperation *operation, id response) {
        [timelineVc reload];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to tweet :(");
    }];
}
@end
