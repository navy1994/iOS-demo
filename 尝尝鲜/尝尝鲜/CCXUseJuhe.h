//
//  CCXUseJuhe.h
//  尝尝鲜
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHAPISDK.h"

typedef void (^Block)(id str);
@interface CCXUseJuhe : NSObject

@property(copy,nonatomic) Block block;


- (void)JuheAPI:(NSString*)path apiID:(NSString*)api_id parameters:(NSDictionary*)param method:(NSString*)method Block:(Block)block;
+(CCXUseJuhe*)shareUseJuhe;

@end
