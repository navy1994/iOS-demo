//
//  YCExpressViewController.h
//  易查
//
//  Created by mac on 15/5/29.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCExpressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *expressDetailTableView;
@property (nonatomic,strong) NSArray *expressList;
@property (nonatomic,strong) NSDictionary *resultDic;
@property (nonatomic,strong) UILabel *express;
@property (nonatomic,strong) UILabel *number;
@property (nonatomic,strong) UIButton *backBtn;

@end
