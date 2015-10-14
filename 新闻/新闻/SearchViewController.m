//
//  SearchViewController.m
//  新闻
//
//  Created by mac on 15/6/7.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "SearchViewController.h"
#import "HYSegmentedControl.h"
#import "ZZNavigationView.h"
#import "PrefixHeader.pch"
#import "UseJuhe.h"
#import "UIImageView+WebCache.h"
#import "NewsViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,ZZNavigationViewDelegate,HYSegmentedControlDelegate,UISearchBarDelegate>{
	UICollectionView *_collectionView;
	UITableView * _tableView;
	NSInteger selectIndex;
	UseJuhe *_useJuhe;
}

@property(nonatomic,strong) HYSegmentedControl *segmentCtrl;
@property(nonatomic,strong) ZZNavigationView *navigation;
@property(nonatomic,strong) NSArray *historyArray;
@property (nonatomic,strong) UISearchBar *seachBar;

@end

@implementation SearchViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_useJuhe = [UseJuhe shareUseJuhe];
	self.view.backgroundColor = [UIColor whiteColor];
    
    _seachBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    _seachBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _seachBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    _seachBar.showsCancelButton = YES;
    _seachBar.placeholder = @"新闻关键字";
    _seachBar.delegate = self;
    [self.view addSubview:_seachBar];
	
	self.segmentCtrl = [[HYSegmentedControl alloc]initWithOriginY:104 Titles:@[@"热门搜索",@"历史搜索"] delegate:self];
	selectIndex = 0;
	[self.view addSubview:_segmentCtrl];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _segmentCtrl.frame.origin.y+_segmentCtrl.frame.size.height, fDeviceWidth, fDeviceHeight-(_segmentCtrl.frame.origin.y+_segmentCtrl.frame.size.height))];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
}

#pragma mark --- ZZNavigationDelegate----
- (void)previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ---- UIsearchDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[_useJuhe JuheAPI:@"http://op.juhe.cn/onebox/news/query" apiID:@"138" parameters:@{@"q":_seachBar.text,@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			[self presentController:result];
		}
	}];
	
}

- (void)presentController:resultData{
	NewsViewController *newsController = [[NewsViewController alloc]init];
	newsController.newsResult = resultData;
	newsController.newsTitle = _navigation.seachBar.text;
	[self.navigationController pushViewController:newsController animated:YES];
}

#pragma mark -- HYSegmentedControlDelegate---
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index{
	selectIndex = index;
	NSLog(@"xuanze=%ld",index);
	[_tableView reloadData];
}

#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (selectIndex == 0) {
		return _hotSearch.count;
	}else{
		return _historyArray.count;
	}
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
	}
	if (selectIndex == 0) {
		cell.textLabel.text = [_hotSearch objectAtIndex:indexPath.row];
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (selectIndex == 0) {
		[_useJuhe JuheAPI:@"http://op.juhe.cn/onebox/news/query" apiID:@"138" parameters:@{@"q":[_hotSearch objectAtIndex:indexPath.row],@"dtype":@"json"} method:@"get" Block:^(id result){
			[self getResultData:result atIndexPath:indexPath];
		}];
	}
}

- (void)getResultData:(id)resultData atIndexPath:(NSIndexPath *)indexPath{
		NewsViewController *newsController = [[NewsViewController alloc]init];
		newsController.newsResult = resultData;
		newsController.newsTitle = [_hotSearch objectAtIndex:indexPath.row];
		[self.navigationController pushViewController:newsController animated:YES];
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
