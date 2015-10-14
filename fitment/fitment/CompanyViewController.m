//
//  CompanyViewController.m
//  fitment
//
//  Created by mac on 15/3/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CompanyViewController.h"
#import "DetailCompanyViewController.h"
#import "NavigationBar.h"
#import "MainViewController.h"
#import "CompanyTableViewCell.h"
#import "FitmentPrefix.pch"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	DBAccess *dbAccess = [[DBAccess alloc]init];
	self.company = [dbAccess getAllCompanys];
	self.defArray = self.company;
	NSLog(@"%d",self.isSave);

	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	//设置导航栏内容
	if (self.isSave) {
		[navigationItem setTitle:@"收藏的公司"];
		UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back.png"]
																	 style:UIBarButtonItemStyleDone
																	target:self
																	action:@selector(clickBackBtn)];
		backItem.tintColor = [UIColor blackColor];
		navigationItem.leftBarButtonItem = backItem;
	}else{
	
		[navigationItem setTitle:@"找公司"];

	}
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

//aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 365, 600)];
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-60)];
	aTableView.delegate = self;
	aTableView.dataSource = self;
	[self.view addSubview:aTableView];
	
}

#pragma mark --TableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (self.isSave) {
		return [self.saveResults count];
	}else{
		return [self.company count];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

	return 80;
}

- (CompanyTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *CellIdentifier = @"Cell";
	CompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[CompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	if (self.isSave) {
		comData = [self.saveResults objectAtIndex:indexPath.row];

	}else{
		comData = [self.company objectAtIndex:indexPath.row];
	}
	cell.nameLabel.text = comData.name;
	cell.logoImgView.image = comData.image;
	cell.addressLabel.text = comData.address;
	
	NSString *str1 = [NSString stringWithFormat:@"口碑值:%d",comData.praiser];
	cell.prasierLabel.text = str1;
	
	NSString *str2 = [NSString stringWithFormat:@"案列:%d",comData.works];
	cell.worksLabel.text = str2;
	
	if (comData.form) {
		[cell.contentView addSubview:cell.houImgView];
	}
	
	if (comData.pay) {
		[cell.contentView addSubview:cell.peiImgView];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	DetailCompanyViewController *detailCtrl = [[DetailCompanyViewController alloc]init];
	detailCtrl.aCompany = [self.company objectAtIndex:indexPath.row];
	[self presentViewController:detailCtrl animated:NO completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- clickBarButton
- (void)clickBackBtn{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:3];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}


@end
