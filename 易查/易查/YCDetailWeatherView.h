//
//  YCDetailWeatherView.h
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "ZZNavigationView.h"

@interface YCDetailWeatherView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HYSegmentedControlDelegate,ZZNavigationViewDelegate>{
	UICollectionView *_collectionView;
	NSArray *hotSearchArray;
	NSMutableArray *historySearchArray;
	NSInteger selectIndex;
	YCDetailWeatherView *cityWeatherView;
}

+ (instancetype)defaultPopupView;

@property(nonatomic,strong) HYSegmentedControl *segmentCtrl;
@property (nonatomic,strong)UIView *innerView;
@property (nonatomic, weak)UIViewController *parentVC;
@property(nonatomic,strong) ZZNavigationView *navigation;
@property(nonatomic,strong) UILabel *cityLabel;

@end
