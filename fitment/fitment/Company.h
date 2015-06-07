//
//  Company.h
//  fitment
//
//  Created by mac on 15/3/20.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Company : NSObject{
	int ID;
	NSString* name;
	NSString* address;
	NSString* information;
	NSString* phoneNumber;
	UIImage* image;
	int praiser; //口碑值
	int works;   //案列
	BOOL form;  //先装修后付款
	BOOL pay;  //先行赔付

}

@property (nonatomic) int ID;
@property (nonatomic) int praiser;
@property (nonatomic) int works;
@property (nonatomic) BOOL form;
@property (nonatomic) BOOL pay;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *infomation;
@property (strong,nonatomic) NSString *phoneNumber;
@property (strong,nonatomic) UIImage *image;

@end
