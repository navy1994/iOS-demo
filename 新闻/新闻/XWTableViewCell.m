//
//  XWTableViewCell.m
//  新闻
//
//  Created by mac on 15/6/7.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "XWTableViewCell.h"
#import "PrefixHeader.pch"

@implementation XWTableViewCell
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, 20)];
		_title.textAlignment = NSTextAlignmentCenter;
		_title.font = [UIFont boldSystemFontOfSize:15];
		[self.contentView addSubview:_title];
		self.content = [[UIWebView alloc]initWithFrame:CGRectMake(5, 25, fDeviceWidth-10, 50)];
		[self.contentView addSubview:_content];
		self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-160)/2, 75, 180, 130)];
		[self.contentView addSubview:self.imageView];
		self.src = [[UILabel alloc]initWithFrame:CGRectMake(5, 205, (fDeviceWidth-10)/2, 20)];
		_src.textAlignment = NSTextAlignmentLeft;
		_src.font = [UIFont boldSystemFontOfSize:11];
		[self.contentView addSubview:_src];
		self.pdate = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2, 205, (fDeviceWidth-10)/2, 20)];
		_pdate.textAlignment = NSTextAlignmentRight;
		_pdate.font = [UIFont boldSystemFontOfSize:11];
		[self.contentView addSubview:_pdate];
	}
	return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
