//
//  HomeViewController.h
//  fitment
//
//  Created by mac on 15/3/4.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AdvertisingColumn.h"
#import "CollectionViewCell.h"
#import <sqlite3.h>
#import "Image.h"
#import "DBAccess.h"
#import "Case.h"
#import "CaseDB.h"

@interface HomeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
	AdvertisingColumn *_headerView; //广告栏
	CaseDB *dbCase;
}

@property(nonatomic, strong) UICollectionView *aCollectionView; 
@property(strong, nonatomic) NSMutableArray *headViewImage;
@property(strong, nonatomic) NSMutableArray *imgArray;
@property(nonatomic, strong) NSMutableArray *image; //用来存放从数据库取出的图片的可变数组
@property(nonatomic, strong) NSMutableArray *cases;
@property(nonatomic, strong) Case *aCase;
@end
