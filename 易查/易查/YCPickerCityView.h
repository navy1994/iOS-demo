//
//  YCPickerCityView.h
//  易查
//
//  Created by mac on 15/5/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCPickerCityView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong) UIPickerView *pickerCity;
@property (nonatomic, weak)UIViewController *parentVC;
@property(nonatomic,strong) NSString *cityName;

@end
