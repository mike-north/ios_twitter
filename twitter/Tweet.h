//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *id;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *authorName;
@property (nonatomic, strong, readonly) NSString *authorHandle;
@property (nonatomic, strong, readonly) NSString *authorAvatarUrl;


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
