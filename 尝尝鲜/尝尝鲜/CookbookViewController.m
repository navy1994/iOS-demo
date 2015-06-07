//
//  CookbookViewController.m
//  尝尝鲜
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CookbookViewController.h"
#import "MenuTableViewCell.h"
#import "CCXDeatilViewController.h"
#import "CCXPrefix.pch"

@interface CookbookViewController ()

@end

@implementation CookbookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
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
	
	self.navigation = [[CCXNavigationView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, height)];
	_navigation.type = type;
	_navigation.leftImage  = [UIImage imageNamed:@"nav_chbackbtn.png"];
	_navigation.delegate = self;
	_navigation.seachBar.text = _selectMenu;
	_navigation.navigaionBackColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	_menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_menuTableView.dataSource = self;
	_menuTableView.delegate = self;
	_menuTableView.rowHeight = 90;
	[self.view addSubview:_menuTableView];

}

#pragma mark --- CCXNavigationDelegate
- (void)previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _menuData.count;
}

- (MenuTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
	}
	cell.imageView.frame = CGRectMake(10, 10, 100, 70);
	cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[[_menuData objectAtIndex:indexPath.row]objectForKey:@"albums"]objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
	cell.titleLabel.frame = CGRectMake(115, 10, fDeviceWidth-115, 30);
	cell.titleLabel.text = [[_menuData objectAtIndex:indexPath.row]objectForKey:@"title"];
	cell.tags.frame = CGRectMake(115, 40, fDeviceWidth-115, 20);
	cell.tags.text = [[_menuData objectAtIndex:indexPath.row]objectForKey:@"tags"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	CCXDeatilViewController *detailMenuController = [[CCXDeatilViewController alloc]init];
	detailMenuController.detailDic = [_menuData objectAtIndex:indexPath.row];
	[self presentViewController:detailMenuController animated:NO completion:NULL];
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
