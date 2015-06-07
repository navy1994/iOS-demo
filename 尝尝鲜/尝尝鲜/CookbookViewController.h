//
//  CookbookViewController.h
//  尝尝鲜
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCXNavigationView.h"

@interface CookbookViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CCXNavigationViewDelegate>{
	UITableView *_menuTableView;
}

@property (nonatomic,strong) CCXNavigationView *navigation;
@property (nonatomic,strong) NSArray *menuData;
@property (nonatomic,strong) NSString *selectMenu;

@end
