//
//  AppDelegate.m
//  fitment
//
//  Created by mac on 15/3/4.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>

//第三方平台的SDK头文件，根据需要的平台导入
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import <QZoneConnection/ISSQZoneApp.h>
#import <FacebookConnection/ISSFacebookApp.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <RennSDK/RennSDK.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

#import <GooglePlus/GooglePlus.h>
#import <Pinterest/Pinterest.h>
#import "YXApi.h"

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ImageViewController.h"
#import "CompanyViewController.h"
#import "ProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	
	MainViewController *mainVC = [[MainViewController alloc]init];
	mainVC.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	
	self.window.rootViewController = mainVC;
	
	NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:@"未登录",@"userName", nil];
	[[NSUserDefaults standardUserDefaults]registerDefaults:defaultValues];
	
	[self.window makeKeyAndVisible];
	
	//初始化ShareSDK
	[ShareSDK registerApp:@"74b7e3de6584"];
	
	[self initializePlat];
	
	return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
	return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
	return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}

- (void)initializePlat
{
	/**
	 连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
	 http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
	 **/
	[ShareSDK connectSinaWeiboWithAppKey:@"4079682763"
							   appSecret:@"4a83fd558a47adac09033ec5875db2e8"
							 redirectUri:@"https://github.com/navy1994/iOS-demo.git"];
							// weiboSDKCls:[WeiboSDK class]];

	/**
	 连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
	 http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
	 
	 如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
	 **/
	[ShareSDK connectTencentWeiboWithAppKey:@"801564407"
								  appSecret:@"ff23c57e7429942a9642a9fa0df911d1"
								redirectUri:@"https://github.com/navy1994/iOS-demo.git"];
								   //wbApiCls:[WeiboApi class]];
	
	//连接短信分享
	[ShareSDK connectSMS];
	
//	/**
//	 连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
//	 http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
//	 
//	 如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
//	 **/
//	[ShareSDK connectQZoneWithAppKey:@"100371282"
//						   appSecret:@"aed9b0303e3ed1e27bae87c33761161d"];
//				  // qqApiInterfaceCls:[QQApiInterface class]
//					// tencentOAuthCls:[TencentOAuth class]];
//	
//	/**
//	 连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
//	 http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
//	 **/
//	//    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
//	[ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
//						   appSecret:@"64020361b8ec4c99936c0e3999a9f249"
//						   wechatCls:[WXApi class]];
//	/**
//	 连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
//	 http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
//	 **/
//	//旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
//	//    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
//	
//	[ShareSDK connectQQWithQZoneAppKey:@"100371282"
//					 qqApiInterfaceCls:[QQApiInterface class]
//					   tencentOAuthCls:[TencentOAuth class]];
	
	
	//连接邮件
	[ShareSDK connectMail];
	
	//连接打印
	[ShareSDK connectAirPrint];
	
	//连接拷贝
	[ShareSDK connectCopy];
	
//	/**
//	 连接Line应用以使用相关功能，此应用需要引用LineConnection.framework库
//	 **/
//	[ShareSDK connectLine];
//	
//	/**
//	 连接WhatsApp应用以使用相关功能，此应用需要引用WhatsAppConnection.framework库
//	 **/
//	[ShareSDK connectWhatsApp];
//	
//	/**
//	 连接KakaoTalk应用以使用相关功能，此应用需要引用KakaoTalkConnection.framework库
//	 **/
//	[ShareSDK connectKaKaoTalk];
//	
//	/**
//	 连接KakaoStory应用以使用相关功能，此应用需要引用KakaoStoryConnection.framework库
//	 **/
//	[ShareSDK connectKaKaoStory];
}

/**
 * @brief  托管模式下的初始化平台
 */
//- (void)initializePlatForTrusteeship
//{
//	
//	//导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
//	[ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
//	
//	//导入人人网需要的外部库类型,如果不需要人人网SSO可以不调用此方法
//	[ShareSDK importRenRenClass:[RennClient class]];
//	
//	//导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
//	[ShareSDK importTencentWeiboClass:[WeiboApi class]];
//	
//	//导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
//	[ShareSDK importWeChatClass:[WXApi class]];
//	
//	//导入Google+需要的外部库类型，如果不需要Google＋分享可以不调用此方法
//	[ShareSDK importGooglePlusClass:[GPPSignIn class]
//						 shareClass:[GPPShare class]];
//	
//	//导入Pinterest需要的外部库类型，如果不需要Pinterest分享可以不调用此方法
//	[ShareSDK importPinterestClass:[Pinterest class]];
//	
//	//导入易信需要的外部库类型，如果不需要易信分享可以不调用此方法
//	[ShareSDK importYiXinClass:[YXApi class]];
//}

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
