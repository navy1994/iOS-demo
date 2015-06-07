//
//  SaveCompany.h
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveCompany : NSObject{
	int ID;
	NSString *userName;
	NSString *company;
}
@property (nonatomic) int ID;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *company;

@end
