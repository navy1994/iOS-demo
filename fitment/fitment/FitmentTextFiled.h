//
//  FitmentTextFiled.h
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FitmentTextFiled : UITextField
- (id)initWithFrame:(CGRect)frame andFontOfSize:(CGFloat)fontSize;
- (id)initWithArray:(NSArray*)array andRow:(NSInteger)row;
@end
