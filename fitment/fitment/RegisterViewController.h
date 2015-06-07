//
//  RegisterViewController.h
//  fitment
//
//  Created by mac on 15/3/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "ProfileDB.h"
#import "Profile.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UITextFieldDelegate>{
	ProfileDB *dbProfile;
}

@property (strong, nonatomic) UIButton *aButton;
@property(strong, nonatomic) UIButton *zhuceButton;
@property(strong, nonatomic) UIButton *forgetButton;
@property(strong, nonatomic) UITextField *tf1;
@property(strong, nonatomic) UITextField *tf2;
@property(strong, nonatomic) NSString *profile;
@property(strong, nonatomic) NSString *password;
@property(retain, nonatomic) NSMutableArray *profiles;
@property(retain, nonatomic) Profile *getProfile;
@property (strong, nonatomic) UILabel *wrongLabel;

- (void) clickButtonBackToZhuce;
- (void) clickButtonBackToHome;
- (void) clickLoginButton;
- (void) clickForgetButton:(UIButton*)sender;

@end
