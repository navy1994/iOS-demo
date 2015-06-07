//
//  YCRootViewController.m
//  易查
//
//  Created by mac on 15/5/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//
#define TAG 99
#import "YCRootViewController.h"
#import "PrefixHeader.pch"
#import "RGCardViewLayout.h"
#import "YCCollectionViewCell.h"
#import "YCWeatherViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import "UIViewController+LewPopupViewController.h"
#import "YCPickerCityView.h"

@interface YCRootViewController ()
@property(nonatomic,strong) UILabel *expressLabel;
@property(nonatomic,strong) UIButton *chooseExpressBtn;
@property(nonatomic,strong) NSString *danhao;
@property(nonatomic,strong) UISearchBar *expressSB;
@end

@implementation YCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	RGCardViewLayout *flowLayout=[[RGCardViewLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i5"]];
	//_collectionView.backgroundColor = [UIColor colorWithRed:191.f/255 green:57.f/255 blue:152.f/255 alpha:1];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
	
	//注册cell和ReusableView（相当于头部）
	[_collectionView registerClass:[YCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
	
	UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleswipePressGesture:)];
	swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
	[_expressView addGestureRecognizer:swipeGesture];
}

-(void)handleswipePressGesture:(UISwipeGestureRecognizer*)sender{
	if (sender.direction == UISwipeGestureRecognizerDirectionRight){
		//[_expressView removeGestureRecognizer:sender];
		[_expressView removeFromSuperview];
	}
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 1;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 3;
}


//每个UICollectionView展示的内容
-(YCCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cell";
	YCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	[cell sizeToFit];
	if (!cell) {
		NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
	}
	
	cell.aLayoutView = [[YCLayoutView alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth*5/6-10,fDeviceHeight*5/6-10) withTag:indexPath.section];
	cell.aLayoutView.rootConteoller = self;
	switch (indexPath.section) {
		case 0:
		    {
			YCPickerCityView *cityPickerView = [[YCPickerCityView alloc]initWithFrame:CGRectMake(5, fDeviceHeight*5/6-200, fDeviceWidth*5/6-10,200)];
			cityPickerView.parentVC = self;
			cell.aLayoutView.imageView.image = [UIImage imageNamed:@"i1"];
			cell.aLayoutView.mainLabel.text = @"天气查询";
			[cell.aLayoutView.seachBar removeFromSuperview];
			[cell.contentView addSubview:cell.aLayoutView];
			[cell.contentView addSubview:cityPickerView];
			}
		    break;
		case 1:
			cell.aLayoutView.imageView.image = [UIImage imageNamed:@"i2"];
			cell.aLayoutView.mainLabel.text = @"物流查询";
			cell.aLayoutView.seachBar.placeholder = @"单号";
			cell.aLayoutView.seachBar.tag = 1;
			[cell.contentView addSubview:cell.aLayoutView];
			break;
		case 2:
			cell.aLayoutView.imageView.image = [UIImage imageNamed:@"i3"];
			cell.aLayoutView.mainLabel.text = @"商品比价";
			cell.aLayoutView.seachBar.placeholder = @"商品详情";
			cell.aLayoutView.seachBar.tag = 2;
			[cell.contentView addSubview:cell.aLayoutView];
			break;
        default:
			break;
	}
	
	return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
		return CGSizeMake(fDeviceWidth*5/6-10, fDeviceHeight*5/6-10);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(fDeviceHeight/12, fDeviceWidth/12, fDeviceHeight/12, fDeviceWidth/12);
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

@end
