//
//  SortMenuViewController.h
//  尝尝鲜
//
//  Created by mac on 15/6/3.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SortMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView *_menuTableView;
}

@property (nonatomic,strong) NSArray *menuData;
@property (nonatomic,strong) NSString *selectMenu;
@property (nonatomic) NSInteger currentData1Index;
@property (nonatomic) NSInteger currentData1SelectedIndex;
@property (nonatomic) BOOL isClassity;


@property (nonatomic,strong) NSArray *data;
@end
