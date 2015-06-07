//
//  YCDetailWeatherView.m
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCDetailWeatherView.h"
#import "PrefixHeader.pch"
#import "JHAPISDK.h"
#import "LewPopupViewAnimationDrop.h"
#import "UIViewController+LewPopupViewController.h"
#import "YCWeatherViewController.h"


@implementation YCDetailWeatherView

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil];
		_innerView.frame = frame;
		_innerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self addSubview:_innerView];
		[self initWithLayout];
	}
	return self;
}

- (void)initWithLayout{
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
	
	self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height-10)];
	_navigation.type = type;
	_navigation.leftImage  = [UIImage imageNamed:@"nav_chbackbtn.png"];
	_navigation.seachBar.placeholder = @"城市名";
	_navigation.delegate = self;
	_navigation.navigaionBackColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.innerView addSubview:_navigation];
	
	self.segmentCtrl = [[HYSegmentedControl alloc]initWithOriginY:_navigation.frame.origin.y+_navigation.frame.size.height Titles:@[@"热门搜索",@"历史搜索"] delegate:self];
	selectIndex = 0;
	[self.innerView addSubview:_segmentCtrl];
	
	UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _segmentCtrl.frame.origin.y+_segmentCtrl.frame.size.height, self.frame.size.width, self.frame.size.height - _segmentCtrl.frame.origin.y-_segmentCtrl.frame.size.height) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor whiteColor];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.innerView addSubview:_collectionView];
	
	//注册cell和ReusableView（相当于头部）
	[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
	
	hotSearchArray = @[@"北京",@"上海",@"天津",@"深圳",@"杭州",@"郑州",@"合肥",@"重庆",@"成都",@"西安",@"武汉",@"南京"];
}

+ (instancetype)defaultPopupView{
	return [[YCDetailWeatherView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth*2/3-10, fDeviceHeight*2/3-10)];
}

#pragma mark --- ZZNavigationDelegate----
- (void)previousToViewController{
//	YCRootViewController *rootViewController = [[YCRootViewController alloc]init];
//	[self presentViewController:rootViewController animated:YES completion:NULL];
 [_parentVC lew_dismissPopupViewWithanimation:[LewPopupViewAnimationDrop new]];
}

- (void)rightButtonClickEvent{
	
}

#pragma mark -- HYSegmentedControlDelegate---
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index{
	selectIndex = index;
	NSLog(@"xuanze=%ld",index);
	[_collectionView reloadData];
}

#pragma mark --- UICollectionViewDataSource---
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	if (selectIndex) {
		return historySearchArray.count;
	}else{
		return hotSearchArray.count;
	}
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cell";
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	for (UIView *view in cell.contentView.subviews) {
		if (view) {
			[view removeFromSuperview];
		}
	}
	[cell sizeToFit];
	if (cell == nil) {
		NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
	}
	
	self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (fDeviceWidth-25)/8, (fDeviceWidth-25)/16)];
	_cityLabel.textAlignment = NSTextAlignmentCenter;
	_cityLabel.font = [UIFont boldSystemFontOfSize:14];
	[cell.contentView addSubview:_cityLabel];
	
	if (selectIndex) {
		
	}else{
		_cityLabel.text = [hotSearchArray objectAtIndex:indexPath.row];
	}
	
	return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//边距占5*4=20 ，2个
	//图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
	return CGSizeMake((fDeviceWidth-25)/8, (fDeviceWidth-25)/16);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	return 5;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	_navigation.seachBar.text = [hotSearchArray objectAtIndex:indexPath.row];
	NSString *path = @"http://op.juhe.cn/onebox/weather/query";
	NSString *api_id = @"73";
	NSString *method = @"GET";
	NSDictionary *param = @{@"cityname":[hotSearchArray objectAtIndex:indexPath.row],@"dtype":@"json"};
	
	[self JuheAPI:path apiID:api_id parameters:param method:method];
}

- (void)JuheAPI:(NSString*)path apiID:(NSString*)api_id parameters:(NSDictionary*)param method:(NSString*)method{
	JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
	[juheapi executeWorkWithAPI:path
						  APIID:api_id
					 Parameters:param
						 Method:method
						Success:^(id responseObject){
							if ([[param objectForKey:@"dtype"]isEqualToString:@"xml"]) {
								NSLog(@"****xml***\n %@",responseObject);
							}
							else{
								int error_code = [[responseObject objectForKey:@"error_code"] intValue];
								if (!error_code) {
									[self presentReqResult:responseObject];
									//NSLog(@"%@",responseObject);
								}else{
									NSLog(@"%@",responseObject);
								}
								
							}
						} Failure:^(NSError *error){
							NSLog(@"error:%@",error.description);
					 }];
	
}

-(void)presentReqResult:(id)responseData{
	int resCode = [[responseData objectForKey:@"error_code"] intValue];
	if (resCode != 0) {
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"报错" message:[responseData objectForKey:@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alertView show];
	}else{
		YCWeatherViewController * weatherVC = [[YCWeatherViewController alloc]init];
		NSDictionary *jsonResult = [responseData objectForKey:@"result"];
		weatherVC.jsonResult = jsonResult;
		//NSLog(@"jsonResult:%@",jsonResult);
		//result = jsonResult;
		[_parentVC presentViewController:weatherVC animated:NO completion:NULL];
	}
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

@end
