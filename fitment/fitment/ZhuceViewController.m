//
//  ZhuceViewController.m
//  fitment
//
//  Created by mac on 15/5/6.
#import "ZhuceViewController.h"
#import "NavigationBar.h"
#import "FitmentPrefix.pch"
#import "RegisterViewController.h"

@interface ZhuceViewController ()

@end

@implementation ZhuceViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initWithNavigation];
	[self initWithUI];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)initWithNavigation{
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//创建一个右边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	//设置导航栏内容
	[navigationItem setTitle:@"注册用户"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
}

- (void)initWithUI{
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 290) style:UITableViewStyleGrouped];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	[self.view addSubview:aTableView];
	self.regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.regBtn.frame = CGRectMake(0, 450, ScreenWidth, 40);
	[self.regBtn setTitle:@"确定注册" forState:UIControlStateNormal];
	self.regBtn.backgroundColor = [UIColor colorWithRed:41.0/250.0 green:140.0/250.0 blue:232.0/250.0 alpha:1];
	[self.regBtn addTarget:self action:@selector(clickBtnToRegister) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.regBtn];
	self.titleArray = @[@"基本信息",@"安全信息"];
	self.left1 = @[@"姓名",@"密码", @"密码"];
	self.left2 = @[@"密保问题",@"密保答案"];
	self.right1 = @[@"请输入用户名",@"请输入密码",@"请再次输入密码"];
	self.right2 = @[@"请输入密保问题",@"请输入密保答案"];
}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return [self.left1 count];
			break;
		case 1:
			return [self.left2 count];
			break;
		default:
			return 0;
			break;
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 50;
}

#pragma mark -- tableView delegate
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return [self.titleArray objectAtIndex:section];
			break;
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
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	switch (indexPath.section)
	{
		case 0:
			cell.textLabel.frame = CGRectMake(20, 8, 80, 30);
			cell.textLabel.text = [self.left1 objectAtIndex:indexPath.row];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			switch (indexPath.row)
		{
			case 0:
				_nameTextField = [[FitmentTextFiled alloc]initWithArray:self.right1 andRow:indexPath.row];
				_nameTextField.delegate = self;
				[cell.contentView addSubview:_nameTextField];
				break;
			case 1:
				_pswTextField = [[FitmentTextFiled alloc]initWithArray:self.right1 andRow:indexPath.row];
				_pswTextField.delegate = self;
				[_pswTextField setSecureTextEntry:YES];
				[cell.contentView addSubview:_pswTextField];
				break;
			case 2:
				_pswTextField1 = [[FitmentTextFiled alloc]initWithArray:self.right1 andRow:indexPath.row];
				_pswTextField1.delegate = self;
				[_pswTextField1 setSecureTextEntry:YES];
				[cell.contentView addSubview:_pswTextField1];
				break;
			default:
				break;
		}
			
			break;
		case 1:
			cell.textLabel.frame = CGRectMake(20, 8, 80, 30);
			cell.textLabel.text = [self.left2 objectAtIndex:indexPath.row];
			cell.textLabel.backgroundColor = [UIColor clearColor];
			switch (indexPath.row)
		{
			case 0:
				_safeQuestionTf = [[FitmentTextFiled alloc]initWithArray:self.right2 andRow:indexPath.row];
				_safeQuestionTf.delegate = self;
				[cell.contentView addSubview:_safeQuestionTf];
				break;
			case 1:
				_safeResultTf = [[FitmentTextFiled alloc]initWithArray:self.right2 andRow:indexPath.row];
				_safeResultTf.delegate = self;
				[cell.contentView addSubview:_safeResultTf];
				break;
			default:
				break;
		}
			break;
  default:
			break;
	}
	
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[_nameTextField resignFirstResponder];
	[_pswTextField resignFirstResponder];
	[_pswTextField1 resignFirstResponder];
	[_safeQuestionTf resignFirstResponder];
	[_safeResultTf resignFirstResponder];
	return YES;
}

#pragma mark -- clickBtn
- (void)clickBtnToBack
{
	RegisterViewController *registerCtl = [[RegisterViewController alloc]init];
	[self presentViewController:registerCtl animated:NO completion:NULL];
}

- (void)clickBtnToRegister{
	dbProfile = [[ProfileDB alloc]init];
	//	if (![dbUser searchUserOfName:_nameTextField.text]) {
	//
	//	}
	if ([_pswTextField.text isEqual:_pswTextField1.text]) {
		Profile *user = [[Profile alloc]init];
		user.name = _nameTextField.text;
		user.password = _pswTextField.text;
		user.safeQuestion = _safeQuestionTf.text;
		user.safeResult = _safeResultTf.text;
		[dbProfile insertToDB:user];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"注册成功,请登录!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
		RegisterViewController *registerCtl = [[RegisterViewController alloc]init];
		[self presentViewController:registerCtl animated:NO completion:NULL];
	}
	
}



@end
