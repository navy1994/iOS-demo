//
//  XHTableViewCell.m
//  笑话大全
//
//  Created by mac on 15/6/6.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "XHTableViewCell.h"
#import "PrefixHeader.pch"

@implementation XHTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.content = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, fDeviceWidth-20, 140)];
		_content.font = [UIFont boldSystemFontOfSize:13];
		_content.numberOfLines = 8;
		[self.contentView addSubview:_content];
		self.updatetime = [[UILabel alloc]initWithFrame:CGRectMake(10, 145, fDeviceWidth-20, 20)];
		_updatetime.textAlignment = NSTextAlignmentRight;
		_updatetime.font = [UIFont boldSystemFontOfSize:12];
		[self.contentView addSubview:_updatetime];
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
