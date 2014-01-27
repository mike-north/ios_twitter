//
//  ComposeTweetViewController.h
//  twitter
//
//  Created by Mike North on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeTweetViewController : UIViewController
-(id) initWithTweet:(id)tweet;
@property (weak) NSMutableArray *tweets;

@end
