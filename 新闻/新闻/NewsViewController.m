
//
//  NewsViewController.m
//  新闻
//
//  Created by mac on 15/6/7.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "NewsViewController.h"
#import "PrefixHeader.pch"
#import "UseJuhe.h"
#import "XWTableViewCell.h"
#import "NewsViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>{
	UITableView *_tableView;
	UseJuhe *_useJuhe;
}
@property(nonatomic,strong) NSArray *data;

@end

@implementation NewsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_useJuhe = [UseJuhe shareUseJuhe];
    
    self.title = _newsTitle;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
	
	_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.rowHeight = 230;
	[self.view addSubview:_tableView];
	//注册
	[SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
	[SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
	//设定图片存储顺序
	[SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
	SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
	//NSLog(@"newsResult:%@",_newsResult);
}

- (void)flushCache
{
	[SDWebImageManager.sharedManager.imageCache clearMemory];
	[SDWebImageManager.sharedManager.imageCache clearDisk];
	[_tableView reloadData];
}

- (void)previousToViewController{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _newsResult.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(XWTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
//    CATransform3D transform3D = CATransform3DIdentity;
//    transform3D = CATransform3DScale(transform3D, 1.5f, 1.5f, 1.f);
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

- (XWTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *Indetifier = @"cell";
	XWTableViewCell *cell = (XWTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
	if (!cell) {
		cell = [[XWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
		cell.title.text = [[_newsResult objectAtIndex:indexPath.row]objectForKey:@"title"];
        NSString *str = [[_newsResult objectAtIndex:indexPath.row]objectForKey:@"content"];
        cell.content.delegate = self;
        [cell.content setScalesPageToFit:YES];
        [cell.content loadHTMLString:str baseURL:nil];
		[cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[_newsResult objectAtIndex:indexPath.row]objectForKey:@"img"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
						  placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
		cell.src.text = [[_newsResult objectAtIndex:indexPath.row]objectForKey:@"src"];
		cell.pdate.text = [[_newsResult objectAtIndex:indexPath.row]objectForKey:@"pdate"];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	DetailViewController *detailController = [[DetailViewController alloc]init];
	detailController.newsTitle = [[_newsResult objectAtIndex:indexPath.row]objectForKey:@"title"];
	detailController.urlString = [[_newsResult objectAtIndex:indexPath.row]objectForKey:@"url"];
	[self.navigationController pushViewController:detailController animated:YES];
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
