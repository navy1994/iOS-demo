//
//  DetailCaseViewController.m
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "DetailCaseViewController.h"
#import "MainViewController.h"
#import "NavigationBar.h"
#import "FitmentPrefix.pch"

@interface DetailCaseViewController ()

@end

@implementation DetailCaseViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	dbCase = [[CaseDB alloc]init];
	self.cases = [dbCase getAllData];
	
	float ret = self.image.size.height / self.image.size.width;//适配图片
	self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.width * ret)];
	NSLog(@"%f",self.view.bounds.size.height);
	self.imageView.image = self.image;
	
	[self.view addSubview:self.imageView];
	
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//创建一个左边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickButtonToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	
	self.aCase = [self.cases objectAtIndex:self.indexRow];
	
	//设置导航栏内容
	[navigationItem setTitle:self.aCase.name];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
	UILabel *aLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 80+self.view.bounds.size.width * ret, ScreenWidth-10, 30)];
	aLabel1.text = @"户型简介";
	aLabel1.font = [UIFont boldSystemFontOfSize:16];
	[self.view addSubview:aLabel1];
	
	self.huxingLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 80+self.view.bounds.size.width * ret+30, ScreenWidth-10, 30)];
	self.huxingLb.font = [UIFont boldSystemFontOfSize:14];
	self.huxingLb.text = self.aCase.huxing;
	[self.view addSubview:self.huxingLb];
	
	UILabel *aLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 80+self.view.bounds.size.width * ret+80, ScreenWidth-10, 30)];
	aLabel2.text = @"案例简介";
	aLabel2.font = [UIFont boldSystemFontOfSize:16];
	[self.view addSubview:aLabel2];
	
	self.jianjieLb = [[UITextView alloc]initWithFrame:CGRectMake(5, 80+self.view.bounds.size.width * ret+80+30, ScreenWidth-10, 200)];
	self.jianjieLb.text = self.aCase.jianjie;
	self.jianjieLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.jianjieLb];
	
}

- (void) clickButtonToBack{
	MainViewController *mainViewController = [[MainViewController alloc]init];
	mainViewController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainViewController setSelectedIndex:0];
	[self presentViewController:mainViewController animated:NO completion:NULL];
}
@end
