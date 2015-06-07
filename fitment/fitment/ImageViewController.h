//
//  ImageViewController.h
//  fitment
//
//  Created by mac on 15/3/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CollectionViewCell.h"
#import <sqlite3.h>
#import "Image.h"
#import "DBAccess.h"

@interface ImageViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
	
}

@property(nonatomic, strong) UICollectionView *collectionView;//列表，布局图库
@property(nonatomic, strong) NSMutableArray *image; //用来存放从数据库取出的图片的可变数组
@end
