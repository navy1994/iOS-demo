//
//  Case.h
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Case : NSObject{
    int ID;
	NSString *huxing;
	NSString *jianjie;
	NSString *name;
}

@property (nonatomic) int ID;
@property (nonatomic,retain) NSString *huxing;
@property (nonatomic,retain) NSString *jianjie;
@property (nonatomic,retain) NSString *name;

@end
