//
//  YCRootViewController.h
//  易查
//
//  Created by mac on 15/5/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YCRootViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>{
	UICollectionView *_collectionView;
}

@property (nonatomic,strong) UIView * expressView;

@end
