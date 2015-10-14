//
//  SortMenuViewController.m
//  尝尝鲜
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "SortMenuViewController.h"
#import "MenuTableViewCell.h"
#import "CCXDeatilViewController.h"
#import "JSDropDownMenu.h"
#import "CCXUseJuhe.h"
#import "CCXPrefix.pch"
#import "UIImageView+WebCache.h"

@interface SortMenuViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>{
	JSDropDownMenu *menu;
	CCXUseJuhe *_useJuhe;
}
@end

@implementation SortMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_useJuhe = [CCXUseJuhe shareUseJuhe];
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
	menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 20) andHeight:45];
	menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
	menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
	menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
	menu.dataSource = self;
	menu.delegate = self;
	[self.view addSubview:menu];
	
	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[backButton setImage:[UIImage imageNamed:@"nav_chbackbtn.png"] forState:UIControlStateNormal];
	backButton.frame = CGRectMake(-10, -8, 100, 60);
	[backButton addTarget:self action:@selector(previousToViewController) forControlEvents:UIControlEventTouchUpInside];
	[menu addSubview:backButton];
	_menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, menu.frame.origin.y+menu.frame.size.height, fDeviceWidth, fDeviceHeight-menu.frame.size.height-20)];
	_menuTableView.dataSource = self;
	_menuTableView.delegate = self;
	_menuTableView.rowHeight = 90;
	[self.view addSubview:_menuTableView];
	
	// 指定默认选中
	if (_isClassity) {
		_currentData1Index = 1;
		_currentData1SelectedIndex = 1;
		[_menuTableView setHidden:YES];
	}else{
		[_menuTableView setHidden:NO];
	}
	//注册
	[SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
	[SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
	//设定图片存储顺序
	[SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
	SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
}

- (void)flushCache
{
	[SDWebImageManager.sharedManager.imageCache clearMemory];
	[SDWebImageManager.sharedManager.imageCache clearDisk];
}


#pragma mark --- CCXNavigationDelegate
- (void) previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark --- SDropDownMenuDelegate

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
	return 1;
}

- (BOOL)haveRightTableViewInColumn:(NSInteger)column{
	return YES;
}

- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
	return 0.3;
}

- (NSInteger)currentLeftSelectedRow:(NSInteger)column{
	return _currentData1Index;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
	if (leftOrRight == 0) {
		return _data.count;
	}else{
		return [[[_data objectAtIndex:leftRow]objectForKey:@"list"]count];
	}
}

- (NSString*)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
	if (_isClassity) {
	NSLog(@"select=%@",[[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"name"]);
		return [[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"name"];
		
	}else{
		return _selectMenu;
	}
	
}

- (NSString*)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
	if (indexPath.leftOrRight == 0){
		return [[_data objectAtIndex:indexPath.row]objectForKey:@"name"];
	 }else{
		 return [[[[_data objectAtIndex:indexPath.leftRow]objectForKey:@"list"]objectAtIndex:indexPath.row]objectForKey:@"name"];
	 }
	
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
	if (indexPath.leftOrRight == 0) {
		NSLog(@"indexrow1=%ld",indexPath.row);
		_currentData1Index = indexPath.row;
		return;
	}else{
		NSLog(@"indexrow2=%ld",indexPath.row);
		_currentData1SelectedIndex = indexPath.row;
		if ([_menuTableView isHidden]) {
			[_menuTableView setHidden:NO];
			[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/index" apiID:@"46" parameters:@{@"cid":[[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"id"],@"dtype":@"json"} method:@"get" Block:^(id result){
				if (result) {
					[self presentController:result];
				}
			}];
		}else{
			[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/index" apiID:@"46" parameters:@{@"cid":[[[_data[_currentData1Index]objectForKey:@"list"]objectAtIndex:_currentData1SelectedIndex]objectForKey:@"id"],@"dtype":@"json"} method:@"get" Block:^(id result){
				if (result) {
					[self presentController:result];
				}
			}];
		}
	}
}

- (void)presentController:resultData{
	_menuData = [resultData objectForKey:@"data"];
	[_menuTableView reloadData];
}


#pragma merk ---- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _menuData.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(MenuTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//     rotation.m34 = 1.0/ -600;

    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DScale(transform3D, 1.5f, 1.5f, 1.f);
        
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = transform3D;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

- (MenuTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
	}
	cell.imageView.frame = CGRectMake(10, 10, 100, 70);
	[cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[[_menuData objectAtIndex:indexPath.row]objectForKey:@"albums"]objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
					  placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
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
