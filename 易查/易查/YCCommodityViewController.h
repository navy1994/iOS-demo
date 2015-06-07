//
//  YCCommodityViewController.h
//  易查
//
//  Created by mac on 15/5/30.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNavigationView.h"

@interface YCCommodityViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ZZNavigationViewDelegate,UISearchBarDelegate>{
	UICollectionView *_collectionView;
}

@property (nonatomic,strong) NSArray *resultArray;
@property(nonatomic,strong) ZZNavigationView *navigation;

@end
