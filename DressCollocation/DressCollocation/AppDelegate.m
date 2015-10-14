//
//  AppDelegate.m
//  DressCollocation
//
//  Created by mac- t4 on 15/9/15.
//  Copyright (c) 2015年 上海科文麦格里实业有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "DCHomeViewController.h"
#import "DCStoreViewController.h"
#import "DCCollocationViewController.h"
#import "DCShopcartViewController.h"
#import "DCIndividualViewController.h"

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    
    return YES;
}

- (void)setupViewControllers {
    UIViewController *homeViewController = [[DCHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    UIViewController *storeViewController = [[DCStoreViewController alloc] init];
    UIViewController *storeNavigationController = [[UINavigationController alloc] initWithRootViewController:storeViewController];
    
    UIViewController *collectionViewController = [[DCCollocationViewController alloc] init];
    UIViewController *collectionNavigationController = [[UINavigationController alloc] initWithRootViewController:collectionViewController];
    
    UIViewController *shopcartViewController = [[DCShopcartViewController alloc] init];
    UIViewController *shopcartNavigationController = [[UINavigationController alloc] initWithRootViewController:shopcartViewController];
    
    UIViewController *individualViewController = [[DCIndividualViewController alloc] init];
    UIViewController *individualNavigationController = [[UINavigationController alloc] initWithRootViewController:individualViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[homeNavigationController, storeNavigationController, collectionNavigationController, shopcartNavigationController, individualNavigationController]];
    
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];

    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
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
