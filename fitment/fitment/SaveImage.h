//
//  SaveImage.h
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SaveImage : NSObject{
	int ID;
	NSString *userName;
	UIImage *image;
}

@property (nonatomic) int ID;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) UIImage *image;

@end
