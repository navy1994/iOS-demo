//
//  AppDelegate.m
//  笑话大全
//
//  Created by mac on 15/6/6.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "AppDelegate.h"
#import "JHOpenidSupplier.h"
#import "HomeViewController.h"
#import "ImageViewController.h"
#import "SDImageCache.h"
@interface AppDelegate ()
@property (nonatomic,strong) HomeViewController *homeViewController;
@property (nonatomic,strong) ImageViewController *imageViewController;
@property (strong, nonatomic) UINavigationController *rootNavigationController;
@property (strong, nonatomic) UINavigationController *imageNavigationController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	//Add a custom read-only cache path
	NSString *bundledPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CustomPathImages"];
	[[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];

	[[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH6c3c73807228c394b5440b0ed3788c5f"];
	self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	
	self.homeViewController = [[HomeViewController alloc]init];
	self.rootNavigationController = [[UINavigationController alloc]initWithRootViewController:self.homeViewController];
	
	self.imageViewController = [[ImageViewController alloc]init];
	self.imageNavigationController = [[UINavigationController alloc]initWithRootViewController:self.imageViewController];
	
	self.tabBarController = [[UITabBarController alloc]init];
	_tabBarController.tabBar.tintColor = [UIColor whiteColor];
	_tabBarController.tabBar.barTintColor = [UIColor colorWithRed:32.0f/255.0f green:192.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
	
	_tabBarController.viewControllers = [NSArray arrayWithObjects:_rootNavigationController,_imageNavigationController, nil];
	_rootNavigationController.tabBarItem.title = @"笑话";
	_imageNavigationController.tabBarItem.title = @"趣图";
	_tabBarController.selectedViewController = _rootNavigationController;
	
	[self.window addSubview:_tabBarController.view];
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
