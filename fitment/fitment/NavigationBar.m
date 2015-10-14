//
//  NavigationBar.m
//  fitment
//
//  Created by mac on 15/3/22.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar


- (id) initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
        [self setBarTintColor:[UIColor colorWithRed:27.0f/255.0f green:103.0f/255.0f blue:162.0f/255.0f alpha:1.0f]];
        [self setTintColor:[UIColor blackColor]];
		[self setFrame:frame];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
