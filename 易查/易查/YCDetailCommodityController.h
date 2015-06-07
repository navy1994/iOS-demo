//
//  YCDetailCommodityController.h
//  易查
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNavigationView.h"

@interface YCDetailCommodityController : UIViewController<UIWebViewDelegate,ZZNavigationViewDelegate>

@property(nonatomic,strong) UIWebView *commodityWebView;
@property(nonatomic,strong) ZZNavigationView *navigation;
@property(nonatomic,strong) NSString *urlString;

@end
