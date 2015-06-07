//
//  MainViewController.m
//  fitment
//
//  Created by mac on 15/3/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ImageViewController.h"
#import "CompanyViewController.h"
#import "ProfileViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
}

#pragma mark - UI
- (void) initViewController{
	homeViewController = [[HomeViewController alloc]init];
	ImageViewController *imageViewController = [[ImageViewController alloc]init];
	CompanyViewController *companyViewController = [[CompanyViewController alloc]init];
	companyViewController.isSave = NO;
	ProfileViewController *profileViewController = [[ProfileViewController alloc]
													init];
	NSArray *controllers = [NSArray arrayWithObjects:homeViewController,imageViewController,companyViewController,profileViewController,nil];
	
	tabBarcontroller = [[UITabBarController alloc]init];
	
	tabBarcontroller.viewControllers = controllers;
	
	[homeViewController.tabBarItem setTitle:@"主页"];
	homeViewController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	homeViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[imageViewController.tabBarItem setTitle:@"图库"];
	imageViewController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_message_center.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	imageViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[companyViewController.tabBarItem setTitle:@"找公司"];
	companyViewController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	companyViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[profileViewController.tabBarItem setTitle:@"我的"];
	profileViewController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_profile.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	profileViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	self.viewControllers = tabBarcontroller.viewControllers;
	
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
