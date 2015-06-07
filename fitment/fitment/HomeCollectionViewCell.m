//
//  HomeCollectionViewCell.m
//  fitment
//
//  Created by mac on 15/3/16.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "CustomCellBackground.h"

@implementation HomeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = [UIColor whiteColor];
		
		self.imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
		[self addSubview:self.imgview];
		
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		// change to our custom selected background view
		CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
		self.selectedBackgroundView = backgroundView;
	}
	return self;
}

@end
