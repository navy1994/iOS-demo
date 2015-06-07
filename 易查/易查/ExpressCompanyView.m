//
//  ExpressCompanyView.m
//  易查
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "ExpressCompanyView.h"
#import "JHAPISDK.h"
#import "YCUseJuheSdk.h"

@interface ExpressCompanyView ()
@property (nonatomic,strong) NSArray * expressCompanys;

@end

@implementation ExpressCompanyView

- (ExpressCompanyView*)initWithFrame:(CGRect)frame Block:(MyBlock)block{
	self = [super initWithFrame:frame];
	if (self) {
		self.block = block;
		self.expressTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		_expressTableView.rowHeight = 30;
		_expressTableView.dataSource = self;
		_expressTableView.delegate = self;
		[self addSubview:_expressTableView];
		self.expressCompanys = @[@"EMS",@"圆通",@"顺丰",@"申通",@"韵达",@"天天",@"中通"];
		
	}
	return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.expressCompanys.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indentifer = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indentifer];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifer];
	}
		cell.textLabel.text = [_expressCompanys objectAtIndex:indexPath.row];

	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (self.block) {
		NSLog(@"row=%ld",indexPath.row);
		self.block([_expressCompanys objectAtIndex:indexPath.row]);
	}
	[self removeFromSuperview];
}


@end
