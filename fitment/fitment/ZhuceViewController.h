//
//  ZhuceViewController.h
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FitmentTextFiled.h"
#import "Profile.h"
#import "ProfileDB.h"

@interface ZhuceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
	UITableView *aTableView;
	ProfileDB *dbProfile;
}

//注册控件
@property (strong, nonatomic) UIButton *regBtn;
@property (strong, nonatomic) FitmentTextFiled *nameTextField;
@property (strong, nonatomic) FitmentTextFiled *pswTextField;
@property (strong, nonatomic) FitmentTextFiled *pswTextField1;
@property (strong, nonatomic) FitmentTextFiled *safeQuestionTf;
@property (strong, nonatomic) FitmentTextFiled *safeResultTf;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *left1;
@property (strong, nonatomic) NSArray *right1;
@property (strong, nonatomic) NSArray *left2;
@property (strong, nonatomic) NSArray *right2;


- (void) initWithNavigation;
- (void) initWithUI;

- (void) clickBtnToBack;
- (void) clickBtnToRegister;
@end
