//
//  CCXHomeViewController.h
//  尝尝鲜
//
//  Created by mac on 15/5/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCXBaseViewController.h"
#import "AdvertisingColumn.h"
#import "CCXPrefix.pch"
#import "CCXUseJuhe.h"

@interface CCXHomeViewController : CCXBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>{
	UICollectionView *_collectionView;
	AdvertisingColumn *_headerView;
	CCXUseJuhe *_useJuhe;
}
@property(nonatomic,strong) NSArray *classifyArray;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UILabel *label;

@end
