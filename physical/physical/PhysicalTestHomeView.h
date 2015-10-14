//
//  PhysicalTestHomeView.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhysicalTestHomeView : UIView
@property (strong, nonatomic) UILabel *logoLabel;
@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UILabel *sexLabel;
@property (strong, nonatomic) UISegmentedControl *sexSegment;
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UIButton *ageBtn;
@property (strong, nonatomic) UILabel *ageResultLabel;
@property (strong, nonatomic) UIButton *startTestBtn;
@property (strong, nonatomic) UILabel *aboutTestLabel;
@end
