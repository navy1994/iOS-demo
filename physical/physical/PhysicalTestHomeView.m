//
//  PhysicalTestHomeView.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "PhysicalTestHomeView.h"
#import "PhysicalPrefix.pch"

@implementation PhysicalTestHomeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.origin.y, fDeviceWidth, 30)];
        _logoLabel.text = @"食方生活";
        _logoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_logoLabel];
        
        self.tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _logoLabel.frame.origin.y+_logoLabel.frame.size.height+10, fDeviceWidth-10, 30)];
        _tipsLabel.text = @"本测试过程分为9步，可能占用你3-5分钟时间；为了保证测试结果的准确性，请根据您当前的特征认真选择。";
        _tipsLabel.font = [UIFont boldSystemFontOfSize:12];
        _tipsLabel.numberOfLines = 2;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipsLabel];
        
        self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-60, _tipsLabel.frame.origin.y+_tipsLabel.frame.size.height+5, 30, 20)];
        _sexLabel.text = @"性别:";
        _sexLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_sexLabel];
        
        self.sexSegment = [[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
        _sexSegment.frame = CGRectMake(_sexLabel.frame.origin.x+_sexLabel.frame.size.width+5, _sexLabel.frame.origin.y, 120-_sexLabel.frame.size.width-5, 20);
        _sexSegment.tintColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        [self addSubview:_sexSegment];
        
        self.ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-60, _sexLabel.frame.origin.y+_sexLabel.frame.size.height+5, 30, 20)];
        _ageLabel.text = @"年龄:";
        _ageLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_ageLabel];
        
        self.ageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ageBtn.frame = CGRectMake(_ageLabel.frame.origin.x+_ageLabel.frame.size.width+5, _ageLabel.frame.origin.y, 120-_ageLabel.frame.size.width-5, 20);
        _ageBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_ageBtn];
        
        self.ageResultLabel = [[UILabel alloc]initWithFrame:_ageBtn.frame];
        _ageResultLabel.text = @"20岁以下";
        _ageResultLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_ageResultLabel];
        
        self.startTestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startTestBtn.frame = CGRectMake(fDeviceWidth/2-60, _ageLabel.frame.origin.y+_ageLabel.frame.size.height+10, 120, 30);
        [_startTestBtn setTitle:@"开始测试" forState:UIControlStateNormal];
        _startTestBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        [self addSubview:_startTestBtn];
        
        
        self.aboutTestLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _startTestBtn.frame.origin.y+_startTestBtn.frame.size.height+50, fDeviceWidth-30, 150)];
        _aboutTestLabel.text = @"\t本测试软件完全依据中华中医医药会颁布的《中国体质分类与判定》标准（标准号ZYYXH/T157-2009）设计，具有权威性，并已申请软件著作权登记（登记号2013SR137631 ）。";
        _aboutTestLabel.textColor = [UIColor colorWithRed:242.0f/255.0f green:129.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        _aboutTestLabel.font = [UIFont boldSystemFontOfSize:18];
        _aboutTestLabel.numberOfLines = 5;
        [self addSubview:_aboutTestLabel];

    }
    
    return self;
    
}

@end
