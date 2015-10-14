//
//  HomeViewController.m
//  新闻
//
//  Created by mac on 15/6/7.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "HomeViewController.h"
#import "PrefixHeader.pch"
#import "UseJuhe.h"
#import "XWTableViewCell.h"
#import "NewsViewController.h"
#import "SearchViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
	UITableView *_tableView;
	UseJuhe *_useJuhe;
}
@property(nonatomic,strong) NSArray *data;

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_useJuhe = [UseJuhe shareUseJuhe];
    
    self.title = @"今日热点";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tabbar_discover"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClickEvent)];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	[self getJSONData];
	
}

- (void)getJSONData{
	[_useJuhe JuheAPI:@"http://op.juhe.cn/onebox/news/words" apiID:@"138" parameters:@{@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			[self presentController:result];
		}
	}];
}

- (void)presentController:(id)resultData{
	self.data = resultData;
	[_tableView reloadData];
}

- (void)rightButtonClickEvent{
	SearchViewController *searchController = [[SearchViewController alloc]init];
	searchController.hotSearch = _data;
	[self.navigationController pushViewController:searchController animated:YES];
}


#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.data.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
	}
	cell.textLabel.text = [_data objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[_useJuhe JuheAPI:@"http://op.juhe.cn/onebox/news/query" apiID:@"138" parameters:@{@"q":[_data objectAtIndex:indexPath.row],@"dtype":@"json"} method:@"get" Block:^(id result){
		[self getResultData:result atIndexPath:indexPath];
	}];
}

- (void)getResultData:(id)resultData atIndexPath:(NSIndexPath *)indexPath{
	NewsViewController *newsController = [[NewsViewController alloc]init];
	newsController.newsResult = resultData;
	newsController.newsTitle = [_data objectAtIndex:indexPath.row];
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
