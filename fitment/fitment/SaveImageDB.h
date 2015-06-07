//
//  SaveImageDB.h
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
#import "SaveImage.h"


@interface SaveImageDB : NSObject
- (void) closeDatabase;
- (void) initializeDatabase;
- (NSMutableArray*) getAllData;
- (void) insertToDB:(SaveImage*)saveImage;

@end
