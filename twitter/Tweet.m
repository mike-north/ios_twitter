//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)id {
    return [self.data valueOrNilForKeyPath:@"id"];
}

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)authorAvatarUrl {
    return [self.data valueForKeyPath:@"user.profile_image_url"];
}

- (NSString *)authorHandle {
    return [self.data valueForKeyPath:@"user.screen_name"];
}

- (NSString *)authorName {
    return [self.data valueForKeyPath:@"user.name"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
