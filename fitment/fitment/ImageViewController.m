//
//  ImageViewController.m
//  fitment
//
//  Created by mac on 15/3/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "ImageViewController.h"
#import "DetailViewController.h"
#import "NavigationBar.h"
#import "FitmentPrefix.pch"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
	DBAccess *dbAccess = [[DBAccess alloc]init];
	self.image = [dbAccess getAllProducts];
	
	[dbAccess closeDatabase];
	
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
		//设置导航栏内容
	[navigationItem setTitle:@"图库"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 69, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];
	
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.view addSubview:self.collectionView];
	
	[self.collectionView setBackgroundColor:[UIColor blackColor]];
	
	//注册CollectionViewCell，添加cell
	[self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	NSLog(@"%lu",self.image.count);
	return [self.image count];
}
//定义展示的section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

	CGSize size = {ScreenWidth,120};
	return size;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *identify = @"cell";
	CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	[cell sizeToFit];
	if (!cell) {
		NSLog(@"无法创建CollectionViewCell时打印，自定义cell就不可能进来了");
	}
	
		Image *image = [self.image objectAtIndex:indexPath.row];
		
		cell.imgview.image = image.Image;
		NSLog(@"row:%ld,image:%@",indexPath.row,image.Image);
	
	return cell;
}

#pragma --UIColectionViewDelegateFlowLayout
//定义每个UICollectionView大小
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	return CGSizeMake((fDeviceWidth-20)/2, (fDeviceWidth-20)/2);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(0, 5, 0, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	Image *image = [self.image objectAtIndex:indexPath.row];
	DetailViewController *detailViewController = [[DetailViewController alloc]init];
	detailViewController.image = image.Image;
	NSLog(@"选择%ld",indexPath.row);
	detailViewController.indexRow = indexPath.row;
	detailViewController.count = [self.image count];
	[self presentViewController:detailViewController animated:NO completion:NULL];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}


@end
