//
//  CCXBaseViewController.h
//  尝尝鲜
//
//  Created by mac on 15/5/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCXNavigationView.h"

@interface CCXBaseViewController : UIViewController<CCXNavigationViewDelegate>

@property (nonatomic,strong) CCXNavigationView *navigation;
@end
