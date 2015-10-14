//
//  XWTableViewCell.h
//  新闻
//
//  Created by mac on 15/6/7.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIWebView *content;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *src;
@property (nonatomic,strong) UILabel *pdate;

@end
