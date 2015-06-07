//
//  YCWeatherViewController.h
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "ZZNavigationView.h"
#import "YCDetailWeatherView.h"

@interface YCWeatherViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
	UICollectionView *_collectionView;
	NSDictionary *data,*life,*pm25,*realtime,*todayWeather,*wind,*info,*futureInfo;
	NSArray *futureWeather;
	NSString *city;
}

@property (nonatomic,strong) NSDictionary *jsonResult;
@property (nonatomic,strong) UISwipeGestureRecognizer *rightSwipeGwstureRecognizer;
@property (nonatomic,strong) UIButton *openDetailBtn;
@property (nonatomic,strong) NSString *selectCity;

@end
