//
//  CCXBaseViewController.m
//  尝尝鲜
//
//  Created by mac on 15/5/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CCXBaseViewController.h"

@interface CCXBaseViewController ()

@end

@implementation CCXBaseViewController
@synthesize navigation = _navigation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
	
	self.navigation = [[CCXNavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
	_navigation.title = @"尝尝鲜";
	_navigation.navigaionBackColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	[_navigation.seachBar setHidden:YES];
	_navigation.type = type;
	_navigation.delegate = self;
	_navigation.backgroundColor = [UIColor whiteColor];
	
	[self.view addSubview:_navigation];
}

#pragma	mark ---CCXNavigationViewDelegate
- (void)previousToViewController{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClickEvent{
	
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
