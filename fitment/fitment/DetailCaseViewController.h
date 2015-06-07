//
//  DetailCaseViewController.h
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseDB.h"
#import "Case.h"

@interface DetailCaseViewController : UIViewController{
	CaseDB *dbCase;
}
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *cases;
@property (nonatomic) NSInteger indexRow;
@property (nonatomic, strong) Case *aCase;
@property (nonatomic, strong) UILabel *huxingLb;
@property (nonatomic, strong) UITextView *jianjieLb;

- (void) clickButtonToBack;
@end
