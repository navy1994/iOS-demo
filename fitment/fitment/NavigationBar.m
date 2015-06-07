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
		[self setBackgroundImage:[UIImage imageNamed:@"head.png"] forBarMetrics:UIBarMetricsDefault];
//		self.layer.masksToBounds = NO;
//		//设置阴影的高度
//		self.layer.shadowOffset = CGSizeMake(0, 1);
//		//设置透明度
//		self.layer.shadowOpacity = 0.3;
//		self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
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
