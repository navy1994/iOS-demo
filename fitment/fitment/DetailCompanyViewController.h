//
//  DetailCompanyViewController.h
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "SaveCompany.h"
#import "SaveCompanyDB.h"

@interface DetailCompanyViewController : UIViewController{
	UILabel *nameLabel, *addressLabel, *prasierLabel, *worksLabel, *numberLabel;
	UIImageView *houImgView, *peiImgView, *koubeiImgView;
	SaveCompanyDB *dbSaveCompany;
}

@property (nonatomic,strong) Company *aCompany;
@property (nonatomic,strong) SaveCompany *saveCompany;

- (void)clickBackBtn;
- (void)clickBtnSave;
@end
