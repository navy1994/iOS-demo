//
//  Profile.h
//  fitment
//
//  Created by mac on 15/3/20.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Profile : NSObject{
	int ID;
	NSString* name;
	NSString* password;
	NSString* safeQuestion;
	NSString* safeResult;
	UIImage* headimage;
	NSString* company;
	UIImage* fitmentImage;
	
}

@property (nonatomic) int ID;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString* password;
@property (strong,nonatomic) NSString* safeQuestion;
@property (strong,nonatomic) NSString* safeResult;
@property (strong,nonatomic) UIImage* headimage;
@property (strong,nonatomic) NSString* company;
@property (strong,nonatomic) UIImage* fitmentImage;

@end
