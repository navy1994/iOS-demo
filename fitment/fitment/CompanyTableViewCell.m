//
//  CompanyTableViewCell.m
//  fitment
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CompanyTableViewCell.h"

@interface CompanyTableViewCell ()

@end

@implementation CompanyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
	
		self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 5, 300, 20)];
		[_nameLabel setBackgroundColor:[UIColor clearColor]];
		_nameLabel.font = [UIFont boldSystemFontOfSize:15];
		[self.contentView addSubview:_nameLabel];
		
		self.logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 70)];
		[self.contentView addSubview:_logoImgView];
		
		self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 30, 300, 20)];
		_addressLabel.font = [UIFont boldSystemFontOfSize:12];
		[self.contentView addSubview:_addressLabel];
		
		self.koubeiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 55, 20, 20)];
		_koubeiImgView.image = [UIImage imageNamed:@"koubei.png"];
		[self.contentView addSubview:_koubeiImgView];
		
		self.prasierLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 55, 100, 20)];
		_prasierLabel.font = [UIFont boldSystemFontOfSize:10];
		[_prasierLabel setTextColor:[UIColor redColor]];
		[self.contentView addSubview:_prasierLabel];
		
		self.worksLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 55, 50, 20)];
		_worksLabel.font = [UIFont boldSystemFontOfSize:10];
		[_worksLabel setTextColor:[UIColor redColor]];
		[self.contentView addSubview:_worksLabel];

		self.houImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-60, 5, 20, 20)];
		_houImgView.image = [UIImage imageNamed:@"hou.png"];
		
		self.peiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-39, 5, 20, 20)];
		_peiImgView.image = [UIImage imageNamed:@"pei.png"];

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
