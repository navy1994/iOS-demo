//
//  YCExpressViewController.m
//  易查
//
//  Created by mac on 15/5/29.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCExpressViewController.h"
#import "YCExpressTableViewCell.h"
#import "PrefixHeader.pch"

@interface YCExpressViewController ()

@end

@implementation YCExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initWithLayout];
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
	self.expressDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, fDeviceWidth, fDeviceHeight-80)];
	_expressDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_expressDetailTableView.dataSource = self;
	_expressDetailTableView.delegate = self;
	_expressDetailTableView.rowHeight = 70;
	[self.view addSubview:_expressDetailTableView];
	
	self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_backBtn.frame = CGRectMake(0, 20, 60, 40);
	[_backBtn setImage:[UIImage imageNamed:@"nav_chbackbtn"] forState:UIControlStateNormal];
	[_backBtn addTarget:self action:@selector(clickBtnToBack) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_backBtn];
	
	self.express = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, fDeviceWidth-40, 20)];
	_express.text = [NSString stringWithFormat:@"快递公司：%@快递",[_resultDic objectForKey:@"company"]];
	_express.font = [UIFont boldSystemFontOfSize:13];
	_express.textAlignment = NSTextAlignmentRight;
	[self.view addSubview:_express];
	
	self.number = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, fDeviceWidth-40, 20)];
	_number.text = [NSString stringWithFormat:@"单号：%@",[_resultDic objectForKey:@"no"]];
	_number.font = [UIFont boldSystemFontOfSize:13];
	_number.textAlignment = NSTextAlignmentRight;
	[self.view addSubview:_number];
	
	self.expressList = [_resultDic objectForKey:@"list"];
	NSLog(@"expressList=%@",_expressList);
	
}

- (void)clickBtnToBack{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

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
	if (self.expressList) {
		cell.datetime.text = [[self.expressList objectAtIndex:indexPath.row]objectForKey:@"datetime"];
		cell.remark.text = [[self.expressList objectAtIndex:indexPath.row]objectForKey:@"remark"];
		cell.zone.text = [[self.expressList objectAtIndex:indexPath.row]objectForKey:@"zone"];
	}
	
	return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
