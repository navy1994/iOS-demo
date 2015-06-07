//
//  YCExpressTableViewCell.m
//  易查
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCExpressTableViewCell.h"
#import "PrefixHeader.pch"

@implementation YCExpressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.datetime = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, fDeviceWidth, 20)];
		_datetime.font = [UIFont boldSystemFontOfSize:12];
		[self.contentView addSubview:_datetime];
		self.remark = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, fDeviceWidth, 40)];
		_remark.numberOfLines = 2;
		_remark.font = [UIFont boldSystemFontOfSize:11];
		_remark.textColor = [UIColor redColor];
		[self.contentView addSubview:_remark];
		self.zone = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, fDeviceWidth, 20)];
		[self.contentView addSubview:_zone];
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
