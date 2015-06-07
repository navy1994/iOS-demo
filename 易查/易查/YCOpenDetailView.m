//
//  YCOpenDetailView.m
//  易查
//
//  Created by mac on 15/5/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCOpenDetailView.h"

@interface YCOpenDetailView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *aTableView;
@property(nonatomic,strong) UIButton *closeDetailBtn;
@property(nonatomic,strong) UITextView *detailTV;


@end

@implementation YCOpenDetailView

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	if (self) {
		self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 26, self.frame.size.width, self.frame.size.height-30)];
		_aTableView.backgroundColor = [UIColor clearColor];
		_aTableView.rowHeight = 60.f;
		_aTableView.delegate = self;
		_aTableView.dataSource = self;
		[self addSubview:_aTableView];
		
		self.closeDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_closeDetailBtn.frame = CGRectMake(0, 0, self.frame.size.width, 26);
		_closeDetailBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"openDetail.png"]];
		[_closeDetailBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_closeDetailBtn];
	}
	return self;
}

- (void)clickCloseBtn{
	[self removeFromSuperview];
}

#pragma mark --- UITableViewDataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 7;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indentifier = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
		self.detailTV = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, 70)];
		
		[cell.contentView addSubview:_detailTV];
	}
	NSArray *allkeysName = @[@"穿衣",@"感冒",@"空调",@"污染",@"洗车",@"运动",@"紫外线"];
	NSArray *allKeys = [_cityInfo allKeys];
	_detailTV.text = [NSString stringWithFormat:@"%@（%@）：%@",[allkeysName objectAtIndex:indexPath.row],[[_cityInfo objectForKey:[allKeys objectAtIndex:indexPath.row]]objectAtIndex:0],[[_cityInfo objectForKey:[allKeys objectAtIndex:indexPath.row]]objectAtIndex:1]];
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

@end
