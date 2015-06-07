//
//  UseJuhe.h
//  笑话大全
//
//  Created by mac on 15/6/6.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHAPISDK.h"

typedef void (^Block)(id str);
@interface UseJuhe : NSObject

@property(copy,nonatomic) Block block;


- (void)JuheAPI:(NSString*)path apiID:(NSString*)api_id parameters:(NSDictionary*)param method:(NSString*)method Block:(Block)block;
+(UseJuhe*)shareUseJuhe;

@end
