//
//  AppDelegate.h
//  尝尝鲜
//
//  Created by mac on 15/5/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCXHomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
	NSMutableArray *array;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CCXHomeViewController *homeViewController;
@property (strong, nonatomic) UINavigationController *rootNavigationController;

@property (strong, nonatomic) UITabBarController *tabBarController;
@end

