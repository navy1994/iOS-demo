//
//  YCDetailExpressView.h
//  易查
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHAPISDK.h"
#import "LewPopupViewAnimationDrop.h"
#import "UIViewController+LewPopupViewController.h"

@interface YCDetailExpressView : UIView<UITableViewDataSource,UITableViewDelegate>{
	//NSDictionary *_resultDic;
}

@property (nonatomic,strong)UIView *innerView;
@property (nonatomic, weak)UIViewController *parentVC;
@property (nonatomic, strong) UITableView *expressDetailTableView;
@property (nonatomic,strong) NSArray *expressList;
@property (nonatomic,strong) NSDictionary *resultDic;

+ (instancetype)defaultPopupView;
//- (void)setValue:(NSDictionary*)dic;

@end
