//
//  DetailViewController.m
//  fitment
//
//  Created by mac on 15/3/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "DetailViewController.h"
#import "MainViewController.h"
#import "ImageViewController.h"
#import "NavigationBar.h"
#import <ShareSDK/ShareSDK.h>
#import "FitmentPrefix.pch"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
	
	float ret = self.image.size.height / self.image.size.width;
	self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.view.bounds.size.height - self.view.bounds.size.width * ret)/2, self.view.bounds.size.width, self.view.bounds.size.width * ret)];
	self.imageView.image = self.image;
	
	[self.view addSubview:self.imageView];
	
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//创建一个右边按钮
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(clickButtonToSave)];
	
	rightButton.tintColor = [UIColor blackColor];
	
	//创建一个左边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickButtonBackToImage)];
	
	leftButton.tintColor = [UIColor blackColor];
	//设置导航栏内容
	[navigationItem setTitle:[NSString stringWithFormat:@"第%ld张/共%lu张",self.indexRow+1,self.count]];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setRightBarButtonItem:rightButton];
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

	UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[collectButton setImage:[UIImage imageNamed:@"soucang"]  forState:UIControlStateNormal];
	collectButton.frame = CGRectMake(self.view.bounds.size.width/2-100, ScreenHeight-55, 50, 50);
	[collectButton addTarget:self action:@selector(clickCollectImage) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:collectButton];
	
	UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[shareButton setImage:[UIImage imageNamed:@"fenxiang"]  forState:UIControlStateNormal];
	shareButton.frame = CGRectMake(240, ScreenHeight-55, 50, 50);
	[shareButton addTarget:self action:@selector(clickShareImage:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:shareButton];
	
}

- (void) clickCollectImage{

	dbSaveImage = [[SaveImageDB alloc]init];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *aString = [defaults stringForKey:@"userName"];
	self.saveImage.userName = aString;
	self.saveImage.image = self.image;
	[dbSaveImage insertToDB:self.saveImage];
	
}

- (void) clickShareImage:(id)sender{
	NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
 
	//构造分享内容
	id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
									   defaultContent:@"测试一下"
												image:[ShareSDK imageWithPath:imagePath]
												title:@"ShareSDK"
												  url:@"http://www.mob.com"
										  description:@"这是一条测试信息"
											mediaType:SSPublishContentMediaTypeNews];
	//创建弹出菜单容器
	id<ISSContainer> container = [ShareSDK container];
	[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];

 
 
	//弹出分享菜单
	[ShareSDK showShareActionSheet:container
						 shareList:nil
						   content:publishContent
					 statusBarTips:YES
					   authOptions:nil
					  shareOptions:nil
							result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
								
								if (state == SSResponseStateSuccess)
								{
									NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
								}
								else if (state == SSResponseStateFail)
								{
									NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
								}
							}];

}

- (void) clickButtonBackToImage{
	MainViewController *mainViewController = [[MainViewController alloc]init];
	mainViewController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainViewController setSelectedIndex:1];
	[self presentViewController:mainViewController animated:NO completion:NULL];
}

- (void) clickButtonToSave{
	UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	NSString *message = @"呵呵";
	if (!error) {
		message = @"成功保存到相册";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"成功保存到相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
		[alert show];
	}else
	{
		message = [error description];
	}
	NSLog(@"message is %@",message);
}

@end
