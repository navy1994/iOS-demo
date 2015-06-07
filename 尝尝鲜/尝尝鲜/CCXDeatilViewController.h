//
//  CCXDeatilViewController.h
//  尝尝鲜
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCXNavigationView.h"

@interface CCXDeatilViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CCXNavigationViewDelegate>{
	UITableView *_detailTableView;
	float ret;
}


@property (nonatomic,strong) CCXNavigationView *navigation;
@property (nonatomic,strong) NSDictionary *detailDic;

@end
