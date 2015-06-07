//
//  Image.h
//  fitment
//
//  Created by mac on 15/3/20.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Image : NSObject{
	NSString  *Name; //图片名
	NSString  *Id;  //id
	UIImage  *Image; //图片
}

@property(nonatomic,retain)NSString  *Name; //图片名
@property(nonatomic,retain)NSString  *Id;  //id
@property(nonatomic,strong)UIImage  *Image; //图片


@end
