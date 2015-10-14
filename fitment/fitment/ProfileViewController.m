//
//  ProfileViewController.m
//  fitment
//
//  Created by mac on 15/3/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "ProfileViewController.h"
#import "CompanyViewController.h"
#import "NavigationBar.h"
#import "RegisterViewController.h"
#import "DBAccess.h"
#import "FitmentPrefix.pch"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	dbProfile = [[ProfileDB alloc]init];
	[self initWithUI];
}

- (void)initWithUI{
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//设置导航栏内容
	[navigationItem setTitle:@"我"];
	//创建一个右边按钮
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"登录"
																	style:UIBarButtonItemStylePlain
																   target:self
																   action:@selector(clickButtonBackToRegister)];
	rightButton.tintColor = [UIColor blackColor];
	
	//设置导航栏内容
	[navigationItem setTitle:@"我"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
	
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 90)];
	view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[self.view addSubview:view];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults stringForKey:@"userName"] != nil) {
		self.aString = [defaults stringForKey:@"userName"];
		if ([self.aString isEqualToString:@"未登录"]) {
			self.aImage = [UIImage imageNamed:@"weidenglu.png"];
		}else{
			self.users = [dbProfile getAllData];
			for (int i=0; i<[self.users count]; i++) {
				self.sysUser = [self.users objectAtIndex:i];
				if ([self.sysUser.name isEqual:self.aString]) {
					if (self.sysUser.headimage == nil) {
						self.aImage = [UIImage imageNamed:@"weidenglu.png"];
					}else{
						self.aImage = self.sysUser.headimage;
					}
					
				}
			}
		}
		
	}
	//把左右两个按钮添加入导航栏集合中
	if ([self.aString isEqualToString:@"未登录"]) {
		[navigationItem setRightBarButtonItem:rightButton];
	}
	
	self.aLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-25, 70, 100, 20)];
	self.aLabel2.text = self.aString;
	self.aLabel2.textColor = [UIColor blackColor];
	self.aLabel2.backgroundColor = [UIColor clearColor];
	self.aLabel2.font = [UIFont boldSystemFontOfSize:15];
	[view addSubview:self.aLabel2];
	
	self.imageView = [[UIImageView alloc]initWithImage:self.aImage];
	self.imageView.frame = CGRectMake(self.view.bounds.size.width/2-25, 15, 50, 50);
	[self.imageView.layer setCornerRadius:25];
	self.imageView.layer.masksToBounds = YES;
	[view addSubview:self.imageView];
	
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 160) style:UITableViewStyleGrouped];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	[self.view addSubview:aTableView];
	
	self.titleArray = @[@"个人"/*, @"我的收藏"*/,@"系统"];
	self.aArray1 = @[@"修改头像", @"修改密码"];
//	self.aArray2 = @[@"装修公司", @"装修图"];
	self.aArray3 = @[@"退出当前账号"];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableView dataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
        case 0:
			return [self.aArray1 count];
			break;
//		case 1:
//			return [self.aArray2 count];
//			break;
		case 1:
			return [self.aArray3 count];
			break;
        default:
			return 0;
			break;
	}
}

#pragma mark -- tableView delegate

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return [self.titleArray objectAtIndex:section];
			break;
//		case 1:
//			return [self.titleArray objectAtIndex:section];
//			break;
		case 1:
			return [self.titleArray objectAtIndex:section];
			break;
        default:
			return NULL;
			break;
	}
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = [self.aArray1 objectAtIndex:indexPath.row];
			break;
//		case 1:
//			cell.textLabel.text = [self.aArray2 objectAtIndex:indexPath.row];
//			break;
		case 1:
			cell.textLabel.text = [self.aArray3 objectAtIndex:indexPath.row];
			break;
        default:
		    cell.textLabel.text = @"Unknown";
			break;
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		if (indexPath.section == 0) {
			if (indexPath.row == 0) {//修改头像
				
			}else if (indexPath.row == 1){ //修改密码
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入要修改的密码！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
				alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
				self.changPsTf1 = [alert textFieldAtIndex:0];
				self.changPsTf1.delegate = self;
				self.changPsTf1.placeholder = @"Password";
				[self.changPsTf1 setSecureTextEntry:YES];
				self.changPsTf2 = [alert textFieldAtIndex:1];
				self.changPsTf2.delegate = self;
				[alert show];
			}
		}
//		else if (indexPath.section == 1) {
//			if (indexPath.row == 0) {//收藏装修公司
//				CompanyViewController *companyCtrl = [[CompanyViewController alloc]init];
//				companyCtrl.isSave = YES;
//				[self presentViewController:companyCtrl animated:NO completion:NULL];
//		    }
//			if (indexPath.row == 1) {//收藏装修图
//			}
//		}
		else{
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			[defaults setObject:@"未登录" forKey:@"userName"];
			[defaults synchronize];
			[self initWithUI];
			if ([self.aLabel2.text isEqual:@"未登录"]) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已经成功注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
				[alert show];
			}
		}
		
	}

}

#pragma mark --- UITextFiledDelete
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if (self.changPsTf1 == textField || self.changPsTf2 == textField) {
		[self.changPsTf1 resignFirstResponder];
		[self.changPsTf2 resignFirstResponder];
	}
	return YES;
}

#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == alertView.firstOtherButtonIndex) {
		if ([self.changPsTf1.text isEqual:self.changPsTf2.text]) {
			isOk = NO;
		}else{
			isOk = YES;
		}
		if (isOk) {
			UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(170, 0, 60, 20)];
			label.text = @"两次密码不同";
			label.font = [UIFont boldSystemFontOfSize:9];
			label.textColor = [UIColor redColor];
			[self.changPsTf1 addSubview:label];
			
		}
		
	}
}

#pragma mark -- click Button of Event
- (void) clickButtonBackToRegister{
	RegisterViewController *registerVC = [[RegisterViewController alloc]init];
	[self presentViewController:registerVC animated:NO completion:NULL];
}

@end
