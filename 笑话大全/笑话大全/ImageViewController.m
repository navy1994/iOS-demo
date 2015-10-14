//
//  ImageViewController.m
//  笑话大全
//
//  Created by mac on 15/6/6.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "ImageViewController.h"
#import "ZZNavigationView.h"
#import "PrefixHeader.pch"
#import "ImageTableViewCell.h"
#import "UseJuhe.h"
#import "UIImageView+WebCache.h"
#import "EGORefreshTableHeaderView.h"

@interface ImageViewController ()<ZZNavigationViewDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>{
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
	UITableView *_tableView;
	UseJuhe *_useJuhe;
	int page;
}
@property(nonatomic,strong) ZZNavigationView *navigation;
@property(nonatomic,strong) NSArray *data;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

@implementation ImageViewController

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
	_navigation.delegate = self;
	_navigation.title = @"趣图天下";
	[_navigation.cleanBtn addTarget:self action:@selector(flushCache) forControlEvents:UIControlEventTouchUpInside];
	_navigation.navigaionBackColor = [UIColor colorWithRed:32.0f/255.0f green:192.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.rowHeight = 200;
	[self.view addSubview:_tableView];
	page = 1;
    //请求数据
	[self getJSONData];
	if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width, _tableView.bounds.size.height)];
		view.delegate = self;
		[_tableView addSubview:view];
		_refreshHeaderView = view;
	}
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
	//注册
	[SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
	[SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
	//设定图片存储顺序
	[SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
	SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
}

- (void)getJSONData{
	[_useJuhe JuheAPI:@"http://japi.juhe.cn/joke/img/text.from" apiID:@"95" parameters:@{@"page":[NSString stringWithFormat:@"%d",page],@"pagesize":@"20",@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			[self presentController:result];
		}
	}];
}

- (void)presentController:(id)resultData{
	self.data = [resultData objectForKey:@"data"];
	[_tableView reloadData];
	NSLog(@"data=%@",_data);
	
}

- (void)flushCache
{
	[SDWebImageManager.sharedManager.imageCache clearMemory];
	[SDWebImageManager.sharedManager.imageCache clearDisk];
	[_tableView reloadData];
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
	return _data.count;
}

- (ImageTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	ImageTableViewCell *cell = (ImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
	}
	cell.content.text = [[_data objectAtIndex:indexPath.row]objectForKey:@"content"];
	[cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[_data objectAtIndex:indexPath.row]objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
					  placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
	cell.updatetime.text = [[_data objectAtIndex:indexPath.row]objectForKey:@"updatetime"];
	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
