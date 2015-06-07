//
//  YCDetailExpressView.m
//  易查
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCDetailExpressView.h"
#import "YCExpressTableViewCell.h"
#import "PrefixHeader.pch"

@interface YCDetailExpressView ()

@end

@implementation YCDetailExpressView

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
		_innerView.frame = frame;
		_innerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self addSubview:_innerView];
		[self initWithLayout];
	}
	return self;
}

- (void)initWithLayout{
	NSString *system = [UIDevice currentDevice].systemVersion;
	float number = [system floatValue];
	
	CGFloat height = 0.0f;
	NSInteger type = 0;
	if (number <= 6.9) {
		type = 0;
		height = 44.0f;
	}else{
		type = 1;
		height = 66.0f;
	}
	self.expressDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, self.frame.size.width, self.frame.size.height-55)];
	_expressDetailTableView.dataSource = self;
	_expressDetailTableView.delegate = self;
	_expressDetailTableView.rowHeight = 60;
	[self addSubview:_expressDetailTableView];
	NSLog(@"resultDic=%@",_resultDic);
	self.expressList = [_resultDic objectForKey:@"list"];
	NSLog(@"expressList=%@",_expressList);
	
}

//- (void)setValue:(NSDictionary *)dic{
//	_resultDic = dic;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.expressList count];
}

- (YCExpressTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indentifier = @"cell";
	YCExpressTableViewCell *cell = (YCExpressTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indentifier];
	if (!cell) {
		cell = [[YCExpressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
	}
	cell.datetime.text = [[self.expressList objectAtIndex:indexPath.row]objectForKey:@"datetime"];
	cell.remark.text = [[self.expressList objectAtIndex:indexPath.row]objectForKey:@"remark"];
	cell.zone.text = [[self.expressList objectAtIndex:indexPath.row]objectForKey:@"zone"];
	return cell;
}

+ (instancetype)defaultPopupView{
	return [[YCDetailExpressView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth*2/3-10, fDeviceHeight*2/3-10)];
}

- (void)previousToViewController{
	//	YCRootViewController *rootViewController = [[YCRootViewController alloc]init];
	//	[self presentViewController:rootViewController animated:YES completion:NULL];
 [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
}



@end
