//
//  YCWeatherView.m
//  易查
//
//  Created by mac on 15/5/22.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCWeatherView.h"
#import "PrefixHeader.pch"

@implementation YCWeatherView
@synthesize imageView = _imageView;
@synthesize timeLabel = _timeLabel;
@synthesize temperLabel = _temperLabel;
@synthesize weatherLabel = _weatherLabel;
@synthesize windLabel = _windLabel;

- (id)initWithFrame:(CGRect)frame withTag:(float)tag{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = RGB(77.f, 91.f, 104.f);
		_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
		_timeLabel.font = [UIFont boldSystemFontOfSize:15];
		_timeLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_timeLabel];
		_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/4, 30, self.frame.size.width/2, self.frame.size.width/2)];
		[_imageView setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_imageView];
		_temperLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.frame.origin.y+_imageView.frame.size.height+5, self.frame.size.width, 30)];
		_temperLabel.font = [UIFont boldSystemFontOfSize:30*tag];
		_temperLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_temperLabel];
		_weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _temperLabel.frame.origin.y+_temperLabel.frame.size.height+5, self.frame.size.width, 20)];
		_weatherLabel.font = [UIFont boldSystemFontOfSize:20];
		_weatherLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_weatherLabel];
		_windLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _weatherLabel.frame.origin.y+_weatherLabel.frame.size.height+5, self.frame.size.width, 20)];
		_windLabel.font = [UIFont boldSystemFontOfSize:15];
		_windLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_windLabel];
		self.backgroundColor = [UIColor clearColor];
		
	}
	return self;
}

@end
