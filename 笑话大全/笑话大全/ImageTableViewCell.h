//
//  ImageTableViewCell.h
//  笑话大全
//
//  Created by mac on 15/6/6.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *updatetime;
@property(nonatomic,strong) UILabel *content;

@end
