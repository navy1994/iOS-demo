//
//  YCWeatherViewController.m
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCWeatherViewController.h"
#import "YCRootViewController.h"
#import "PrefixHeader.pch"
#import "JHAPISDK.h"
#import "YCUseJuheSdk.h"
#import "YCDetailWeatherView.h"
#import "LewPopupViewAnimationDrop.h"
#import "UIViewController+LewPopupViewController.h"
#import "YCCollectionViewCell.h"
#import "YCOpenDetailView.h"

@interface YCWeatherViewController ()

@end

@implementation YCWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	//self.view.backgroundColor = RGB(77.f, 91.f, 104.f);
	[self initWithLayout];
}
- (void)initWithLayout{
//	NSString *system = [UIDevice currentDevice].systemVersion;
//	float number = [system floatValue];
//	
//	CGFloat height = 0.0f;
//	NSInteger type = 0;
//	if (number <= 6.9) {
//		type = 0;
//		height = 44.0f;
//	}else{
//		type = 1;
//		height = 66.0f;
//	}
	
	UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-26) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor clearColor];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
	
	//注册cell和ReusableView（相当于头部）
	[_collectionView registerClass:[YCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
	
	self.openDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_openDetailBtn.frame = CGRectMake(0, fDeviceHeight-26, fDeviceWidth, 26);
	_openDetailBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"closeDetail.png"]];
	[_openDetailBtn addTarget:self action:@selector(clickDetailBtnEvent) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_openDetailBtn];
	
	
	self.rightSwipeGwstureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
	_rightSwipeGwstureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
	[self.view addGestureRecognizer:_rightSwipeGwstureRecognizer];
	
	realtime = [[_jsonResult objectForKey:@"data"]objectForKey:@"realtime"];
	futureWeather = [[_jsonResult objectForKey:@"data"]objectForKey:@"weather"];
	life = [[_jsonResult objectForKey:@"data"]objectForKey:@"life"];
	info = [life objectForKey:@"info"];
	NSLog(@"realtime:%@",realtime);
}

- (void)clickDetailBtnEvent{
	YCOpenDetailView *detailView = [[YCOpenDetailView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-200, fDeviceWidth, 200)];
	detailView.cityInfo = info;
	[self.view addSubview:detailView];
}


- (void)handleSwipe:(UISwipeGestureRecognizer*)sender{
	if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
		YCRootViewController *rootVC = [[YCRootViewController alloc]init];
//		YCDetailWeatherView * detailWeatherView = [YCDetailWeatherView defaultPopupView];
//		detailWeatherView.parentVC = self;
		[self presentViewController:rootVC animated:YES completion:NULL];
	}
}


#pragma mark --- UICollectionViewDataSource---
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 5;
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

    UIView *aView = [[UIView alloc]init];
	aView.backgroundColor = RGB(77.f, 91.f, 104.f);
	aView.alpha = 0.3;
	[cell.contentView addSubview:aView];
	
	UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 80, 30)];
	cityLabel.text = [NSString stringWithFormat:@"🌐%@",_selectCity];
	cityLabel.font = [UIFont boldSystemFontOfSize:20];
	cityLabel.textAlignment = NSTextAlignmentLeft;
	

	if (indexPath.row>0) {
	cell.aWeatherView = [[YCWeatherView alloc]initWithFrame:CGRectMake(0, 5, (fDeviceWidth-1)/2, 50+fDeviceWidth/2) withTag:0.5f];
		cell.aWeatherView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"q%@.png",[[[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"info"]objectForKey:@"day"]objectAtIndex:0]]];
		cell.aWeatherView.timeLabel.text = [NSString stringWithFormat:@"周%@",[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"week"]];
		aView.frame = CGRectMake(0, 5, (fDeviceWidth-1)/2, 50+fDeviceWidth/2);
	}else{
	[cell.contentView addSubview:cityLabel];
	cell.aWeatherView = [[YCWeatherView alloc]initWithFrame:CGRectMake(0, 60, fDeviceWidth-10, 120+fDeviceWidth/2) withTag:1.0f];
		cell.aWeatherView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"q%@.png",[[realtime objectForKey:@"weather"]objectForKey:@"img"]]];
		cell.aWeatherView.timeLabel.text = [NSString stringWithFormat:@"周%@%@ %@ (实时：%@℃)",[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"week"],[realtime objectForKey:@"date"],[realtime objectForKey:@"moon"],[[realtime objectForKey:@"weather"]objectForKey:@"temperature"]];
		aView.frame = CGRectMake(0, 5, fDeviceWidth, 180+fDeviceWidth/2);
	}
	
	NSLog(@"timeLabel.text:%@",cell.aWeatherView.timeLabel.text);
	cell.aWeatherView.temperLabel.text = [NSString stringWithFormat:@"%@℃ ~ %@℃",[[[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"info"]objectForKey:@"night"]objectAtIndex:2],[[[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"info"]objectForKey:@"day"]objectAtIndex:2]];
	cell.aWeatherView.weatherLabel.text = [NSString stringWithFormat:@"%@",[[[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"info"]objectForKey:@"day"]objectAtIndex:1]];
	cell.aWeatherView.windLabel.text = [NSString stringWithFormat:@"%@",[[[[futureWeather objectAtIndex:indexPath.row]objectForKey:@"info"]objectForKey:@"day"]objectAtIndex:4]];
	
	[cell.contentView addSubview:cell.aWeatherView];
	
	return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//	return UIEdgeInsetsMake(5, 5, 5, 5);
//}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//边距占5*4=20 ，2个
	//图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
	if (indexPath.row == 0) {
		return CGSizeMake(fDeviceWidth, 180+fDeviceWidth/2);
	}else{
		return CGSizeMake((fDeviceWidth-1)/2, 50+fDeviceWidth/2);
	}
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
