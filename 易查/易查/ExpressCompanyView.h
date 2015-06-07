//
//  ExpressCompanyView.h
//  易查
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlock)(NSString *str);

@interface ExpressCompanyView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *expressTableView;
@property(copy,nonatomic) MyBlock block;

-(ExpressCompanyView*)initWithFrame:(CGRect)frame Block:(MyBlock)block;


@end
