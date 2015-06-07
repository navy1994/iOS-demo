//
//  CompanyViewController.h
//  fitment
//
//  Created by mac on 15/3/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "Company.h"
#import "SaveCompany.h"
#import "SaveCompanyDB.h"

@interface CompanyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView *aTableView;
	SaveCompanyDB *dbSaveCompany;
	Company *comData;
}

//@property(nonatomic, strong) UITableView *aTableView;

@property(strong, nonatomic) NSMutableArray *company;
@property(strong, nonatomic) NSArray *defArray;
@property (strong,nonatomic) NSMutableArray *saveCompanys;
@property(strong,nonatomic) NSMutableArray *saveResults;
@property (strong,nonatomic) SaveCompany *saveCompany;
@property(nonatomic) BOOL isSave;



- (void)clickBackBtn;
@end
