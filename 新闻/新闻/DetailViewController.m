//
//  DetailViewController.m
//  新闻
//
//  Created by mac on 15/6/7.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "DetailViewController.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD.h"

@interface DetailViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong) UIWebView *newsWebView;
@property(strong , nonatomic) MBProgressHUD * hud;   //进度指示器
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	self.title = _newsTitle;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_chbackbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(previousToViewController)];
	
	self.newsWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight)];
	_newsWebView.delegate = self;
	[_newsWebView setScalesPageToFit:YES];
	NSString *encodedString = [_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[_newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
	[self.view addSubview:_newsWebView];
    
    _hud = [[MBProgressHUD alloc]initWithView:self.view];
    _hud.delegate = self;
    _hud.dimBackground = TRUE;
    _hud.labelText = @"正在加载";
    [self.view addSubview:_hud];
}

#pragma mark --- ZZNavigationDelegate----
- (void)previousToViewController{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClickEvent{
}

#pragma mark --- UIWEbViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_hud show:YES];
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_hud hide:YES];
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_hud hide:YES];
    NSLog(@"webViewFaildLoad%@",error);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
