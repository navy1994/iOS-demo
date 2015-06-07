//
//  YCUseJuheSdk.h
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Block)(id str);

@interface YCUseJuheSdk : NSObject
@property(copy,nonatomic) Block block;
@property(nonatomic) NSInteger tag;

- (void)JuheAPI:(NSString*)path apiID:(NSString*)api_id parameters:(NSDictionary*)param method:(NSString*)method Block:(Block)block;
+(YCUseJuheSdk *)shareUseJuhe;
@end
