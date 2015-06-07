//
//  FitmentTextFiled.m
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "FitmentTextFiled.h"

@implementation FitmentTextFiled

- (id)initWithFrame:(CGRect)frame andFontOfSize:(CGFloat)fontSize{
	self = [super initWithFrame:frame];
	if (self) {
		self.font = [UIFont boldSystemFontOfSize:fontSize];
		self.textColor = [UIColor colorWithRed:41.0/250.0 green:140.0/250.0 blue:232.0/250.0 alpha:1];
	}
	return self;
}

- (id)initWithArray:(NSArray*)array andRow:(NSInteger)row{
	self = [super init];
	if (self) {
		self.frame = CGRectMake(110, 10, 140, 30);
		self.placeholder = [array objectAtIndex:row];
	}
	return self;
}


@end
