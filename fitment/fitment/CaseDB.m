//
//  CaseDB.m
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CaseDB.h"

@implementation CaseDB
FMDatabase *db;

- (id) init{
	
	if ((self = [super init])) {
		[self initializeDatabase];
	}
	return self;
}

- (void) initializeDatabase{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
	
	//open the database
	db =[FMDatabase databaseWithPath:path];
	if ([db open]) {
		NSLog(@"我进入了用户表");
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

- (NSMutableArray*)getAllData{
	NSMutableArray *cases = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from caseTable"];
	while ([set next]) {
		Case *aCase = [[Case alloc]init];
		aCase.ID = [set intForColumn:@"ID"];
		aCase.huxing = [set stringForColumn:@"huxing"];
		aCase.jianjie = [set stringForColumn:@"jianjie"];
		aCase.name = [set stringForColumn:@"name"];
		[cases addObject:aCase];
	}
	return cases;
}

@end
