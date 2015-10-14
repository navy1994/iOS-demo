//
//  Quiz.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quiz : NSObject{
    int ID;
    NSString *quiz;
}

@property (nonatomic) int ID;
@property (strong,nonatomic) NSString *quiz;


@end
