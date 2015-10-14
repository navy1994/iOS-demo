//
//  SearchMenuViewController.m
//  尝尝鲜
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "SearchMenuViewController.h"
#import "HYSegmentedControl.h"
#import "CCXNavigationView.h"
#import "MenuTableViewCell.h"
#import "CCXDeatilViewController.h"
#import "CCXPrefix.pch"
#import "CCXUseJuhe.h"
#import "UIImageView+WebCache.h"

@interface SearchMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,CCXNavigationViewDelegate,HYSegmentedControlDelegate,UISearchBarDelegate>{
	UICollectionView *_collectionView;
	UITableView * _menuTableView;
	NSInteger selectIndex;
	CCXUseJuhe *_useJuhe;
}

@property(nonatomic,strong) HYSegmentedControl *segmentCtrl;
@property(nonatomic,strong) CCXNavigationView *navigation;
@property(nonatomic,strong) NSArray *historyArray;
@property(nonatomic,strong) UILabel *cityLabel;
@property(nonatomic,strong) NSArray *menuData;

@end

@implementation SearchMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_useJuhe = [CCXUseJuhe shareUseJuhe];
	self.view.backgroundColor = [UIColor whiteColor];
	
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
	_navigation.seachBar.placeholder = @"菜谱关键字";
	_navigation.seachBar.delegate = self;
	_navigation.navigaionBackColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	[self readNSUserDefaults];
	
	_menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_menuTableView.dataSource = self;
	_menuTableView.delegate = self;
	_menuTableView.rowHeight = 90;
	[self.view addSubview:_menuTableView];
	
	self.segmentCtrl = [[HYSegmentedControl alloc]initWithOriginY:_navigation.frame.origin.y+_navigation.frame.size.height Titles:@[@"热门搜索",@"历史搜索"] delegate:self];
	selectIndex = 0;
	[self.view addSubview:_segmentCtrl];
	
	UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _segmentCtrl.frame.origin.y+_segmentCtrl.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height - _segmentCtrl.frame.origin.y-_segmentCtrl.frame.size.height) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor whiteColor];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
	
	//注册cell和ReusableView（相当于头部）
	[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];

	
	if (_isFirstSearch) {
		[_menuTableView setHidden:YES];
	}
	//注册
	[SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
	[SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
	//设定图片存储顺序
	[SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
	SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
}

-(void)readNSUserDefaults
{
	NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
	//读取数组NSArray类型的数据
	_historyArray = [userDefaultes arrayForKey:@"myArray"];
	NSLog(@"myArray======%@",_historyArray);
}

- (void)flushCache
{
	[SDWebImageManager.sharedManager.imageCache clearMemory];
	[SDWebImageManager.sharedManager.imageCache clearDisk];
}


#pragma mark --- ZZNavigationDelegate----
- (void)previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ---- UIsearchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	[searchBar setShowsCancelButton:YES animated:YES];
	searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
	UIButton *cancelButton;
	UIView *topView = searchBar.subviews[0];
	for (UIView *subView in topView.subviews) {
		if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
			cancelButton = (UIButton*)subView;
		}
	}
	if (cancelButton) {
		//Set the new title of the cancel button
		[cancelButton setTitle:@"取消" forState:UIControlStateNormal];
		[cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		cancelButton.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:15];
	}
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar //键盘搜索键 点击 事件
{
	[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/query.php" apiID:@"46" parameters:@{@"menu":_navigation.seachBar.text,@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			[self presentController:result];
		}
	}];
	NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
	//读取数组NSArray类型的数据
	NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
	// NSArray --> NSMutableArray
	NSMutableArray *searTXT = [myArray mutableCopy];
	[searTXT addObject:_navigation.seachBar.text];
	if(searTXT.count > 5)
	{
		[searTXT removeObjectAtIndex:0];
	}else{
		if ([[searTXT objectAtIndex:0]isEqualToString:@"无记录"]) {
			[searTXT removeObjectAtIndex:0];
		}
	}
	//将上述数据全部存储到NSUserDefaults中
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:searTXT forKey:@"myArray"];
	[searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[searchBar setShowsCancelButton:NO animated:YES];
	searchBar.text = nil;
	[searchBar resignFirstResponder];
}

//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//	
//}

- (void)presentController:resultData{
	if ([_menuTableView isHidden]) {
		[_menuTableView setHidden:NO];
		[_segmentCtrl setHidden:YES];
		[_collectionView setHidden:YES];
	}
	_menuData = [resultData objectForKey:@"data"];
	[_menuTableView reloadData];
}

#pragma mark -- HYSegmentedControlDelegate---
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index{
	selectIndex = index;
	NSLog(@"xuanze=%ld",index);
	[self readNSUserDefaults];
	[_collectionView reloadData];
}

#pragma mark --- UICollectionViewDataSource---
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	if (selectIndex) {
		return _historyArray.count;
	}else{
		return _hotSearchArray.count;
	}
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cell";
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	for (UIView *view in cell.contentView.subviews) {
		if (view) {
			[view removeFromSuperview];
		}
	}
	[cell sizeToFit];
	if (cell == nil) {
		NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
	}
	
	self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (fDeviceWidth-25)/4, (fDeviceWidth-25)/8)];
	_cityLabel.textAlignment = NSTextAlignmentCenter;
	_cityLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
	_cityLabel.font = [UIFont boldSystemFontOfSize:14];
	[cell.contentView addSubview:_cityLabel];
	
	if (selectIndex) {
		_cityLabel.text = [_historyArray objectAtIndex:indexPath.row];
	}else{
		_cityLabel.text = [[_hotSearchArray objectAtIndex:indexPath.row]objectForKey:@"name"];
	}
	
	return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake((fDeviceWidth-25)/4, (fDeviceWidth-25)/8);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	return 5;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (selectIndex) {
		
	}else{
		_navigation.seachBar.text = [[_hotSearchArray objectAtIndex:indexPath.row]objectForKey:@"name"];
		NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
		//读取数组NSArray类型的数据
		NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
		// NSArray --> NSMutableArray
		NSMutableArray *searTXT = [myArray mutableCopy];
		[searTXT addObject:[[_hotSearchArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
		if(searTXT.count > 5)
		{
			[searTXT removeObjectAtIndex:0];
		}else{
			if ([[searTXT objectAtIndex:0]isEqualToString:@"无记录"]) {
				[searTXT removeObjectAtIndex:0];
			}
		}
		//将上述数据全部存储到NSUserDefaults中
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setObject:searTXT forKey:@"myArray"];
	}
	[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/query.php" apiID:@"46" parameters:@{@"menu":_navigation.seachBar.text,@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			[self presentController:result];
		}
	}];

}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- UITableViewDelegate
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

@end
