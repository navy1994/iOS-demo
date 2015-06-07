//
//  ProfileDB.h
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "Profile.h"

@interface ProfileDB : NSObject
- (void) closeDatabase;
- (void) initializeDatabase;
- (NSMutableArray*) getAllData;
- (void) insertToDB:(Profile*)user;
- (BOOL) deleteDataOfName:(NSString*)name;
- (BOOL) updateDataOfName:(NSString*)name andSet:(NSString*)string1 andNew:(NSString*)string2;
- (Profile*) searchUserOfName:(NSString*)name;
- (UIImage*) searchImage:(NSString*)name;

@end
