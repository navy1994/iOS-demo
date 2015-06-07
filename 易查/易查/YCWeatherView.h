//
//  YCWeatherView.h
//  易查
//
//  Created by mac on 15/5/22.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWeatherView : UIView{
   UILabel *_timeLabel;
   UIImageView *_imageView;
   UILabel *_temperLabel;
   UILabel *_weatherLabel;
   UILabel *_windLabel;
}

@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *temperLabel;
@property(nonatomic,strong) UILabel *weatherLabel;
@property(nonatomic,strong) UILabel *windLabel;

- (id)initWithFrame:(CGRect)frame withTag:(float)tag;
@end
