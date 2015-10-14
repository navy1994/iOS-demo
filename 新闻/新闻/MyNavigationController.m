//
//  MyNavigationController.m
//  新闻
//
//  Created by mac- t4 on 15/7/31.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "MyNavigationController.h"

@implementation MyNavigationController


- (id)init{
    self = [super init];
    if (self) {
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f]];
        [self.navigationBar setTintColor:[UIColor blackColor]];
    }
    return self;
}
@end
