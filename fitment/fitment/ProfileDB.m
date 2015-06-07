//
//  ProfileDB.m
//  fitment
//
//  Created by mac on 15/5/6.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "ProfileDB.h"

@implementation ProfileDB
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
	FMResultSet *set = [db executeQuery:@"select * from profileTable"];
	while ([set next]) {
		Profile *user = [[Profile alloc]init];
		user.ID = [set intForColumn:@"ID"];
		user.name = [set stringForColumn:@"name"];
		user.password = [set stringForColumn:@"password"];
		user.safeQuestion = [set stringForColumn:@"safequestion"];
		user.safeResult = [set stringForColumn:@"saferesult"];
		NSData *data1 = [set dataForColumn:@"headimage"];
		user.headimage = [UIImage imageWithData:data1];
		user.company = [set stringForColumn:@"company"];
		NSData *data2 = [set dataForColumn:@"fitmentimage"];
		user.fitmentImage = [UIImage imageWithData:data2];
		[users addObject:user];
	}
	return users;
}

- (void)insertToDB:(Profile*)user{
//	NSData *data = UIImagePNGRepresentation(user.headimage);
//	NSString *imgStr = [NSString stringWithFormat:@"%@",data];
	if ([db executeUpdate:@"insert into profileTable(name,password,safequestion,saferesult) values(?,?,?,?)",user.name,user.password,user.safeQuestion,user.safeResult]) {
		NSLog(@"插入数据成功");
		
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
	BOOL isOk;
	if ([db executeUpdate:@"delete from userTable where name=?",name]) {
		NSLog(@"用户删除数据成功");
		isOk = YES;
	}else{
		isOk = NO;
	}
	return isOk;
}

- (BOOL) updateDataOfName:(NSString *)name andSet:(NSString *)string1 andNew:(NSString *)string2{
	bool isOK;
	NSString *sql = [NSString stringWithFormat:@"updata userTable set %@=?, where name=?",string1];
	if ([db executeUpdate:sql,string2,name]) {
		isOK = YES;
		NSLog(@"更新数据成功");
	}
	else{
		NSLog(@"更新数据失败");
		isOK = NO;
	}
	return isOK;
}

- (Profile*)searchUserOfName:(NSString *)name{
	NSLog(@"-----------name=%@",name);
	Profile* user = [[Profile alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from userTable where name=?",name];
	NSLog(@"[set next]=%d",[set next]);
	while ([set next]) {
		user.ID = [set intForColumn:@"ID"];
		user.name = [set stringForColumn:@"name"];
		user.password = [set stringForColumn:@"password"];
		user.safeQuestion = [set stringForColumn:@"safequestion"];
		user.safeResult = [set stringForColumn:@"saferesult"];
		//		NSData *data = [set dataForColumn:@"image"];
		//
		//		user.image = [UIImage imageWithData:data];
	}
	return user;
}

- (UIImage*)searchImage:(NSString *)name{
	UIImage *image = [[UIImage alloc]init];
	
	FMResultSet *set = [db executeQuery:@"select image from userTable where name=?",name];
	NSLog(@"[set next]=%d",[set next]);
	while ([set next]) {
		NSData *data = [set dataForColumn:@"image"];
		NSLog(@"data=%@",data);
		image = [UIImage imageWithData:data];
		NSLog(@"name=%@",image);
	}
	return image;
	
}

@end
