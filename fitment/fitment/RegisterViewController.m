//
//  RegisterViewController.m
//  fitment
//
//  Created by mac on 15/3/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainViewController.h"
#import "ZhuceViewController.h"
#import "NavigationBar.h"
#import "FitmentPrefix.pch"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
     [super viewDidLoad];
	
	dbProfile = [[ProfileDB alloc]init];
	
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//创建一个右边按钮
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"注册账号"
																	style:UIBarButtonItemStyleDone
																   target:self
																   action:@selector(clickButtonBackToZhuce)];
	rightButton.tintColor = [UIColor blackColor];
	
	//创建一个左边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back.png"]
	                                                               style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickButtonBackToHome)];
	
	leftButton.tintColor = [UIColor blackColor];
	//设置导航栏内容
	[navigationItem setTitle:@"装修宝"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setRightBarButtonItem:rightButton];
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
	UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
	imageView.frame = CGRectMake(85, 100, 200, 200);
	[self.view addSubview:imageView];
	
	UILabel *aLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(50, ScreenHeight-250, 50, 50)];
	aLabel2.text = @"账户";
	[self.view addSubview:aLabel2];
	
	UILabel *aLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(50, ScreenHeight-190, 50, 50)];
	aLabel3.text = @"密码";
	[self.view addSubview:aLabel3];
	
	self.tf1 = [[UITextField alloc]initWithFrame:CGRectMake(100, ScreenHeight-250, [UIScreen mainScreen].bounds.size.width - 150, 50)];
	self.tf1.delegate = self;
	self.tf1.borderStyle = UITextBorderStyleRoundedRect;
	self.tf1.placeholder = @"用户名/邮箱/手机号码";
	self.tf1.leftViewMode = UITextFieldViewModeAlways;
	[self.tf1 setClearButtonMode:UITextFieldViewModeWhileEditing];
	self.tf1.keyboardType = UIKeyboardTypeDefault;
	self.tf1.returnKeyType = UIReturnKeyDefault;
	self.tf1.delegate = self;
	[self.view addSubview:self.tf1];
	
	self.tf2 = [[UITextField alloc]initWithFrame:CGRectMake(100, ScreenHeight-190, [UIScreen mainScreen].bounds.size.width - 150, 50)];
	self.tf2.delegate = self;
	self.tf2.borderStyle = UITextBorderStyleRoundedRect;
	self.tf2.placeholder = @"请输入密码";
	[self.tf2 setClearButtonMode:UITextFieldViewModeWhileEditing];
	self.tf2.secureTextEntry = YES;
	self.tf2.keyboardType = UIKeyboardTypeDefault;
	self.tf2.returnKeyType = UIReturnKeyDefault;
	self.tf2.delegate = self;
	[self.view addSubview:self.tf2];
	
	self.profile = self.tf1.text;
	self.password = self.tf2.text;
	
	UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
	registerButton.frame = CGRectMake(50, ScreenHeight-130, [UIScreen mainScreen].bounds.size.width - 100, 50);
	[registerButton setTitle:@"登录" forState:UIControlStateNormal];
	[registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	registerButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[registerButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:registerButton];
	
//	self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	self.forgetButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 525, 100, 20);
//	[self.forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
//	self.forgetButton.backgroundColor = [UIColor clearColor];
//	[self.forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//	self.forgetButton.titleLabel.font = [UIFont boldSystemFontOfSize:10];
//	[self.forgetButton addTarget:self action:@selector(clickForgetButton:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:self.forgetButton];

}

#pragma mark---UITextFiledDelegate
- (bool)textFieldShouldReturn:(UITextField *)textField{
	if (self.tf1 == textField || self.tf2 == textField) {
		[self.tf1 resignFirstResponder];
		[self.tf2 resignFirstResponder];
	}
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) clickButtonBackToHome{
	MainViewController *mainViewController = [[MainViewController alloc]init];
	mainViewController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainViewController setSelectedIndex:3];
	[self presentViewController:mainViewController animated:NO completion:NULL];
}

- (void) clickButtonBackToZhuce{
	ZhuceViewController *zhuceCtrl = [[ZhuceViewController alloc]init];
	[self presentViewController:zhuceCtrl animated:NO completion:NULL];
}

- (void) clickLoginButton{
	self.wrongLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 400, 200, 30)];
	self.wrongLabel.textColor = [UIColor redColor];
	NSLog(@"paofilename=%@",self.tf1.text);
	self.profiles = [dbProfile getAllData];
	for (int i=0; i < [self.profiles count]; i++) {
		self.getProfile = [self.profiles objectAtIndex:i];
		if ([self.getProfile.name isEqual:self.tf1.text]) {
			if ([self.getProfile.password isEqual:self.tf2.text]) {
				self.wrongLabel.text = @"";
				NSLog(@"我进来了");
				NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				[defaults setObject:self.getProfile.name forKey:@"userName"];
				[defaults synchronize];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"小主,您已登录成功O(∩_∩)O~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
				[alert show];
				MainViewController *sysCtrl = [[MainViewController alloc]init];
				sysCtrl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
				[sysCtrl setSelectedIndex:3];
				[self presentViewController:sysCtrl animated:NO completion:NULL];
			}
		}else{
			self.wrongLabel.text = @"用户名或密码错误";
		}
		
	}
	[self.view addSubview:self.wrongLabel];
}

- (void) clickForgetButton:(UIButton *)sender{
	NSLog(@"jgjhgh");
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
