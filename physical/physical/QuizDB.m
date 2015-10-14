//
//  PatientDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "QuizDB.h"

@implementation QuizDB

FMDatabase *db;

- (id) init{
	
	if ((self = [super init])) {
		[self initializeDatabase];
	}
	return self;
}

- (void) initializeDatabase{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"PhysicalQuiz" ofType:@"sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        NSLog(@"表不存在");
    }
	//open the database
	db =[FMDatabase databaseWithPath:path];
	if ([db open]) {
		NSLog(@"open database success");
	}
	else{
		[self closeDatabase];
	}
}

- (void) closeDatabase
{
	[db close];
}

- (NSMutableArray*)getAllData:(NSString *)tableName{
	NSMutableArray *quizs = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"select * from %@Table",tableName]];
	while ([set next]) {
        Quiz *quiz = [[Quiz alloc]init];
        quiz.ID = [set intForColumn:@"ID"];
        quiz.quiz = [set stringForColumn:@"quiz"];
        [quizs addObject:quiz];	}
	return quizs;
}

@end
