//
//  DetailCompanyViewController.m
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "DetailCompanyViewController.h"
#import "MainViewController.h"
#import "NavigationBar.h"

@interface DetailCompanyViewController ()

@end

@implementation DetailCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//设置导航栏内容
	[navigationItem setTitle:self.aCompany.name];
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back.png"]
																 style:UIBarButtonItemStyleDone
																target:self
                                                                action:@selector(clickBackBtn)];
	backItem.tintColor = [UIColor blackColor];
	navigationItem.leftBarButtonItem = backItem;
	
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(clickBtnSave)];
	rightItem.tintColor = [UIColor blackColor];
	navigationItem.rightBarButtonItem = rightItem;

	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
	UIImageView *imgView = [[UIImageView alloc]initWithImage:self.aCompany.image];
	imgView.frame = CGRectMake(self.view.bounds.size.width/2-100, 80, 200, 180);
	[self.view addSubview:imgView];
	
	addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 330, 300, 30)];
	addressLabel.font = [UIFont boldSystemFontOfSize:15];
	addressLabel.text = self.aCompany.address;
	[self.view addSubview:addressLabel];
	
	koubeiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 270, 20, 20)];
	koubeiImgView.image = [UIImage imageNamed:@"koubei.png"];
	[self.view addSubview:koubeiImgView];
	
	prasierLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 270, 100, 20)];
	NSString *str1 = [NSString stringWithFormat:@"口碑值:%d",self.aCompany.praiser];
	prasierLabel.font = [UIFont boldSystemFontOfSize:12];
	[prasierLabel setTextColor:[UIColor redColor]];
	prasierLabel.text = str1;
	[self.view addSubview:prasierLabel];
	
	worksLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 270, 50, 20)];
	NSString *str2 = [NSString stringWithFormat:@"案列:%d",self.aCompany.works];
	worksLabel.text = str2;
	worksLabel.font = [UIFont boldSystemFontOfSize:12];
	[worksLabel setTextColor:[UIColor redColor]];
	[self.view addSubview:worksLabel];
	
	if (self.aCompany.form) {
		houImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-60, 270, 20, 20)];
		houImgView.image = [UIImage imageNamed:@"hou.png"];
		[self.view addSubview:houImgView];
	}
	
	if (self.aCompany.pay) {
		peiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-39, 270, 20, 20)];
		peiImgView.image = [UIImage imageNamed:@"pei.png"];
		[self.view addSubview:peiImgView];
	}
	
	numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 200, 20)];
	numberLabel.font = [UIFont boldSystemFontOfSize:15];
	NSString *str3 = [NSString stringWithFormat:@"联系方式:%@",self.aCompany.phoneNumber];
	numberLabel.text = str3;
	[self.view addSubview:numberLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBackBtn{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:2];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

- (void)clickBtnSave{
	dbSaveCompany = [[SaveCompanyDB alloc]init];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *aString = [defaults stringForKey:@"userName"];
	self.saveCompany.userName = aString;
	self.saveCompany.company = self.aCompany.name;
	[dbSaveCompany insertToDB:self.saveCompany];
}
@end
