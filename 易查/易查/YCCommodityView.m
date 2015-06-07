//
//  YCCommodityView.m
//  易查
//
//  Created by mac on 15/5/31.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCCommodityView.h"
#import "PrefixHeader.pch"

@implementation YCCommodityView

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		self.sppic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.width-10)];
		[self addSubview:_sppic];
		self.spname = [[UILabel alloc]initWithFrame:CGRectMake(5, _sppic.frame.origin.y+_sppic.frame.size.height+5,self.frame.size.width-10, 40)];
		_spname.numberOfLines = 2;
		_spname.font = [UIFont boldSystemFontOfSize:11];
		[self addSubview:_spname];
		self.spprice = [[UILabel alloc]initWithFrame:CGRectMake(5, _spname.frame.origin.y+_spname.frame.size.height+5, _spname.frame.size.width, 20)];
		_spname.font = [UIFont boldSystemFontOfSize:12];
		_spprice.textAlignment = NSTextAlignmentLeft;
		_spprice.textColor = [UIColor redColor];
		[self addSubview:_spprice];
		self.siteName = [[UILabel alloc]initWithFrame:CGRectMake(5, _spprice.frame.origin.y+_spprice.frame.size.height+5, _spprice.frame.size.width, 20)];
		_siteName.font = [UIFont boldSystemFontOfSize:14];
		_siteName.textAlignment = NSTextAlignmentLeft;
		[self addSubview:_siteName];
	}
	return self;
}

@end
