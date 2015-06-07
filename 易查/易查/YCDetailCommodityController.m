//
//  YCDetailCommodityController.m
//  易查
//
//  Created by mac on 15/6/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCDetailCommodityController.h"
#import "PrefixHeader.pch"

@interface YCDetailCommodityController ()
@property(nonatomic,strong) UILabel *aLabel;
@end

@implementation YCDetailCommodityController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	NSString *system = [UIDevice currentDevice].systemVersion;
	float number = [system floatValue];
	
	CGFloat height = 0.0f;
	NSInteger type = 0;
	if (number <= 6.9) {
		type = 0;
		height = 44.0f;
	}else{
		type = 1;
		height = 66.0f;
	}
	
	self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, height)];
	_navigation.type = type;
	_navigation.leftImage  = [UIImage imageNamed:@"nav_chbackbtn.png"];
	[_navigation.seachBar setHidden:YES];
	_navigation.title = @"商品详情";
	_navigation.delegate = self;
	_navigation.navigaionBackColor = [UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
	_navigation.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_navigation];
	
	
	
	self.commodityWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
	_commodityWebView.delegate = self;
	[_commodityWebView setScalesPageToFit:YES];
	NSString *encodedString = [_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[_commodityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
	[self.view addSubview:_commodityWebView];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- ZZNavigationDelegate----
- (void)previousToViewController{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)rightButtonClickEvent{
}

#pragma mark --- UIWEbViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//	self.aLabel = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/4, fDeviceHeight/2, fDeviceWidth/2, 30)];
//	_aLabel.text = @"正在加载。。。";
//	[self.view addSubview:_aLabel];
	NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
//	[self.aLabel removeFromSuperview];
	NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	NSLog(@"webViewFaildLoad%@",error);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
