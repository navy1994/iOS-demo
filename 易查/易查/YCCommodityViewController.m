//
//  YCCommodityViewController.m
//  易查
//
//  Created by mac on 15/5/30.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCCommodityViewController.h"
#import "PrefixHeader.pch"
#import "YCCollectionViewCell.h"
#import "YCUseJuheSdk.h"
#import "YCDetailCommodityController.h"
#import "UIImageView+WebCache.h"

@interface YCCommodityViewController ()

@end

@implementation YCCommodityViewController

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
	
	self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, height)];
	_navigation.type = type;
	_navigation.leftImage  = [UIImage imageNamed:@"nav_chbackbtn.png"];
	_navigation.seachBar.placeholder = @"商品";
	_navigation.seachBar.delegate = self;

	_navigation.delegate = self;
	_navigation.navigaionBackColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor clearColor];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
	
	//注册cell和ReusableView（相当于头部）
	[_collectionView registerClass:[YCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
	
	//注册
	[SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
	[SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
	//设定图片存储顺序
	[SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
	SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;

}

#pragma mark --- ZZNavigationDelegate----
- (void)previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)rightButtonClickEvent{
}

- (void)flushCache
{
	[SDWebImageManager.sharedManager.imageCache clearMemory];
	[SDWebImageManager.sharedManager.imageCache clearDisk];
	[_collectionView reloadData];
}

#pragma mark --- UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	YCUseJuheSdk *useJuhe = [YCUseJuheSdk shareUseJuhe];
	[useJuhe JuheAPI:@"http://api2.juheapi.com/mmb/search/simple" apiID:@"137" parameters:@{@"keyword":_navigation.seachBar.text,@"dtype":@"json"} method:@"get" Block:^(id result){
		[self presentReqResult:result];
	}];

}

-(void)presentReqResult:(id)responseData{
	if (responseData) {
		_resultArray = responseData;
		[_collectionView reloadData];
	}
}


#pragma mark --- UICollectionViewDataSource---
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return _resultArray.count;
}


//每个UICollectionView展示的内容
-(YCCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cell";
	YCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	for (UIView *view in cell.contentView.subviews) {
		if (view) {
			[view removeFromSuperview];
		}
	}
	[cell sizeToFit];
	if (!cell) {
		NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
	}
	
	cell.aCommodityView = [[YCCommodityView alloc]initWithFrame:CGRectMake(0, 0,(fDeviceWidth-1)/2, (fDeviceWidth-1)/2+95)];
	if (_resultArray) {
		[cell.aCommodityView.sppic sd_setImageWithURL:[NSURL URLWithString:[[[_resultArray objectAtIndex:indexPath.row]objectForKey:@"sppic"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
						  placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];

       //cell.aCommodityView.sppic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_resultArray objectAtIndex:indexPath.row]objectForKey:@"sppic"]]]];
		cell.aCommodityView.spname.text = [[_resultArray objectAtIndex:indexPath.row]objectForKey:@"spname"];
		cell.aCommodityView.spprice.text = [NSString stringWithFormat:@"￥%@",[[_resultArray objectAtIndex:indexPath.row]objectForKey:@"spprice"]];
		cell.aCommodityView.siteName.text = [[_resultArray objectAtIndex:indexPath.row]objectForKey:@"siteName"];
		
		[cell.contentView addSubview:cell.aCommodityView];
		cell.backgroundColor = [UIColor whiteColor];
	}
	return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//边距占5*4=20 ，2个
	//图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
	return CGSizeMake((fDeviceWidth-1)/2, (fDeviceWidth-1)/2+95);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	return 1;
	
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	YCDetailCommodityController *detailViewController = [[YCDetailCommodityController alloc]init];
	detailViewController.urlString = [[_resultArray objectAtIndex:indexPath.row]objectForKey:@"spurl"];
	[self presentViewController:detailViewController animated:NO completion:NULL];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
