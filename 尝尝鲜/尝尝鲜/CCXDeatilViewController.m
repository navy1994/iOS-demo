//
//  CCXDeatilViewController.m
//  尝尝鲜
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CCXDeatilViewController.h"
#import "CCXPrefix.pch"
#import "MenuTableViewCell.h"
#import "DeatilView.h"
#import "UIImageView+WebCache.h"

@interface CCXDeatilViewController ()
@property (nonatomic,strong) NSArray *stepArray;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) DeatilView *detailView;

@end

@implementation CCXDeatilViewController

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
	[_navigation.seachBar setHidden:YES];
	_navigation.navigaionBackColor = [UIColor groupTableViewBackgroundColor];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[_detailDic objectForKey:@"albums"]objectAtIndex:0]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
	ret = self.image.size.height / self.image.size.width;
	
	_detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_detailTableView.dataSource = self;
	_detailTableView.delegate = self;
	_detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_detailTableView];
	
	self.detailView = [[DeatilView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceWidth*2/3+240)];
	_detailView.rootImgeView.image = self.image;
	_detailView.titleLabel.text = [_detailDic objectForKey:@"title"];
	_detailView.ingreLabel.text = [_detailDic objectForKey:@"ingredients"];
	_detailView.burdenLabel.text = [_detailDic objectForKey:@"burden"];
	
	self.stepArray = [_detailDic objectForKey:@"steps"];
	
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
- (void)previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

	if(section == 1){
		return _stepArray.count;
	}else{
		return 1;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0) {
		return fDeviceWidth*2/3+250;
	}else{
		return 150;
	}
	
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if (section == 1) {
		return @"步骤";
	}else if(section == 2){
		return @"小贴士";
	}else{
		return nil;
	}
}

- (MenuTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//	static NSString *Indetifier = @"cell";
//	MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Indetifier];
//	if (!cell) {
//		cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
//		
//	}
     MenuTableViewCell *cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	if (indexPath.section == 0) {
		[cell.contentView addSubview:_detailView];
	}else if(indexPath.section == 1){
		[self initCell:cell cellAtIndexPath:indexPath];

	}else{
	    cell.tags.frame = CGRectMake(10, 10, fDeviceWidth-20, 80);
		cell.tags.numberOfLines = 5;
		cell.tags.text = [_detailDic objectForKey:@"imtro"];
	}
	   return cell;
}

- (void)initCell:(MenuTableViewCell*)cell cellAtIndexPath:(NSIndexPath *)indexPath{
			cell.tags.frame = CGRectMake(10, 10, fDeviceWidth-20, 30);
			cell.tags.text = [NSString stringWithFormat:@"%@",[[[_detailDic objectForKey:@"steps"]objectAtIndex:indexPath.row]objectForKey:@"step"]];
			cell.imageView.frame = CGRectMake(20, 45, 130, 95);
	[cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[[[_detailDic objectForKey:@"steps"]objectAtIndex:indexPath.row]objectForKey:@"img"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
	   placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
