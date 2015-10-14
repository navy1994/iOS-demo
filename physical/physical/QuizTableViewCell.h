//
//  QuizTableViewCell.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLRadioButton.h"
#import "PhysicalQuizViewController.h"

@interface QuizTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) DLRadioButton *radio1;
@property(strong, nonatomic) DLRadioButton *radio2;
@property(strong, nonatomic) DLRadioButton *radio3;
@property(strong, nonatomic) DLRadioButton *radio4;
@property(strong, nonatomic) DLRadioButton *radio5;

@end
