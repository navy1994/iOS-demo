//
//  ProfileViewController.h
//  fitment
//
//  Created by mac on 15/3/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"
#import "ProfileDB.h"
#import "SaveCompany.h"
#import "SaveCompanyDB.h"
#import "SaveImage.h"
#import "SaveImageDB.h"

@interface ProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{
	UITableView *aTableView;
	ProfileDB *dbProfile;
	SaveCompanyDB *dbSaveCompany;
	SaveImageDB *dbSaveImage;
	BOOL isOk;
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *aArray1;
@property (strong, nonatomic) NSArray *aArray2;
@property (strong, nonatomic) NSArray *aArray3;
@property (strong, nonatomic) UIButton *chageImage;
@property (strong, nonatomic) UILabel *aLabel2;
@property (strong, nonatomic) UIImage *aImage;
@property (strong, nonatomic) NSString *aString;

@property (strong,nonatomic) NSMutableArray *users;
@property (strong,nonatomic) NSMutableArray *saveCompanys;
@property (strong,nonatomic) NSMutableArray *saveImages;
@property (strong,nonatomic) Profile *sysUser;
@property (strong,nonatomic) SaveCompany *saveCompany;
@property (strong,nonatomic) SaveImage *saveImage;

@property (strong, nonatomic) UITextField *changPsTf1;
@property (strong, nonatomic) UITextField *changPsTf2;

- (void) clickButtonBackToRegister;
- (void)initWithUI;
@end
