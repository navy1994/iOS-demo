//
//  CaseDB.h
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "Case.h"

@interface CaseDB : NSObject
- (void) closeDatabase;
- (void) initializeDatabase;
- (NSMutableArray*) getAllData;

@end
