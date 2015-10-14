//
//  HomeViewController.m
//  笑话书
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "HomeViewController.h"
#import "PrefixHeader.pch"
#import "XHTableViewCell.h"
#import "UseJuhe.h"
#import "EGORefreshTableHeaderView.h"

@interface HomeViewController ()<ZZNavigationViewDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>{
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
	UITableView *_tableView;
	UseJuhe *_useJuhe;
	int page;
}
@property(nonatomic,strong) NSArray *data;
@property(nonatomic,strong) ZZNavigationView *navigation;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_useJuhe = [UseJuhe shareUseJuhe];
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
	[self.navigationController setNavigationBarHidden:YES animated:NO];
	self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, height)];
	_navigation.type = type;
	[_navigation.cleanBtn setHidden:YES];
	_navigation.delegate = self;
	_navigation.title = @"笑话大全";
	_navigation.navigaionBackColor = [UIColor colorWithRed:32.0f/255.0f green:192.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.rowHeight = 200;
	_tableView.sectionFooterHeight = height;
	[self.view addSubview:_tableView];
	page = 1;
	[self getJSONData];
	if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width, _tableView.bounds.size.height)];
		view.delegate = self;
		[_tableView addSubview:view];
		_refreshHeaderView = view;
	}
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
	
}

- (void)getJSONData{
	[_useJuhe JuheAPI:@"http://japi.juhe.cn/joke/content/text.from" apiID:@"95" parameters:@{@"page":[NSString stringWithFormat:@"%d",page],@"pagesize":@"20",@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			[self presentController:result];
		}
	}];
}

- (void)presentController:(id)resultData{
	self.data = [resultData objectForKey:@"data"];
	[_tableView reloadData];
	//NSLog(@"data=%@",_data);
}

#pragma mark --- ZZNavigationDelegate
- (void)rightButtonClickEvent{
	
}

- (void)previousToViewController{
	
}

#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSLog(@"data=%@\n",_data);
	return self.data.count;
}


- (XHTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	XHTableViewCell *cell = (XHTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[XHTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
	}
	cell.content.text = [[_data objectAtIndex:indexPath.row]objectForKey:@"content"];
	cell.updatetime.text = [[_data objectAtIndex:indexPath.row]objectForKey:@"updatetime"];
	return cell;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	page++;
	[self getJSONData];
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
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
