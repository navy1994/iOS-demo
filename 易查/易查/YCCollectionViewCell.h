//
//  YCCollectionViewCell.h
//  易查
//
//  Created by mac on 15/5/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCLayoutView.h"
#import "YCWeatherView.h"
#import "YCCommodityView.h"

@interface YCCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong) YCLayoutView *aLayoutView;
@property(nonatomic,strong) YCWeatherView *aWeatherView;
@property(nonatomic,strong) YCCommodityView *aCommodityView;

@end
