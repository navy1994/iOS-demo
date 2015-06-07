//
//  SaveCompanyDB.m
//  fitment
//
//  Created by mac on 15/5/7.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "SaveCompanyDB.h"

@implementation SaveCompanyDB
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
	NSMutableArray *users = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from savecompanyTable"];
	while ([set next]) {
		SaveCompany *user = [[SaveCompany alloc]init];
		user.ID = [set intForColumn:@"ID"];
		user.userName = [set stringForColumn:@"username"];
		user.company = [set stringForColumn:@"company"];

		[users addObject:user];
	}
	return users;
}

- (void)insertToDB:(SaveCompany*)saveCompany{
	if ([db executeUpdate:@"insert into savecompanyTable(username,company) values(?,?)",saveCompany.userName,saveCompany.company]) {
		NSLog(@"插入数据成功");
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"收藏公司成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}
}
@end
