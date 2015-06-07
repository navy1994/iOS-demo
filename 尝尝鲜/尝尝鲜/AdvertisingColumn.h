//
//  AdvertisingColumn.h
//  fitment
//
//  Created by mac on 15/3/15.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisingColumn : UIView<UIScrollViewDelegate>{
	NSTimer *_timer;
}

//广告栏
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *imageNum;
@property (nonatomic) NSInteger totalNum;

- (void) setArray:(NSMutableArray *)imgAraay;

- (void) openTimer;
- (void) closeTimer;

@end
