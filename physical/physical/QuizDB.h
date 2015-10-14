//
//  PatientDB.h
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "Quiz.h"

@interface QuizDB : NSObject

- (NSMutableArray*) getAllData:(NSString*)tableName;
- (void) closeDatabase;
- (void) initializeDatabase;

@end
