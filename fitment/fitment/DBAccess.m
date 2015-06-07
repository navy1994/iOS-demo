//
//  DBAccess.m
//  fitment
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "DBAccess.h"
#import "Image.h"
#import "Company.h"

@implementation DBAccess

sqlite3* database;

- (id) init{
	
	if ((self = [super init])) {
		[self initializeDatabase];
	}
	return self;
}

- (void) initializeDatabase{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
	
	//open the database
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
	{
		NSLog(@"Opening datbase");
	}
	else
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database:'%s'.", sqlite3_errmsg(database));
	}
}

- (void) closeDatabase
{
	if (sqlite3_close(database) != SQLITE_OK) {
		NSAssert1(0, @"Failed to close database:'%s'.", sqlite3_errmsg(database));
	}
}

//得到图库数据表数据
- (NSMutableArray*) getAllProducts{
	NSMutableArray *images = [[NSMutableArray alloc]init];
	
	const char *sql = "SELECT * from imageTable";
	
	sqlite3_stmt *statement;
	
	int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	if (sqlResult == SQLITE_OK)
	{
		while (sqlite3_step(statement) == SQLITE_ROW)
		{
			
			NSLog(@"成功执行到这一步");
			Image *image = [[Image alloc]init];
			int bytes = sqlite3_column_bytes(statement, 2);
			Byte *value = (Byte*)sqlite3_column_blob(statement, 2);
			if (bytes != 0 && value != NULL)
			{
				NSData * data = [NSData dataWithBytes:value length:bytes];
				image.Image = [UIImage imageWithData:data];
				NSLog(@"image=%@---",image.Image);
				
			}
			char *name = (char*)sqlite3_column_text(statement, 0);
			char *ID = (char*)sqlite3_column_text(statement, 1);
			
			image.Name = (name) ? [NSString stringWithUTF8String:name] : @"";
			image.Id = (ID) ? [NSString stringWithUTF8String:ID] : @"";
			NSLog(@"name=%@",image.Name);
			[images addObject:image];

		}
		sqlite3_finalize(statement);
	}
	else
	{
		NSLog(@"Problem with the datebase:%d",sqlResult);
	}
	return images;
	
}

//得到公司数据表数据
- (Profile*) getAllProfile:(NSString *)profileName{
	//NSMutableArray *companys = [[NSMutableArray alloc]init];
	Profile* getProfile = NULL;
	
	const char *sql = "select * from profileTable where name=?";
	
	sqlite3_stmt *statement;
	
	int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	if (sqlResult == SQLITE_OK)
	{
		sqlite3_bind_text(statement, 1, [profileName UTF8String], -1, NULL);

		while (sqlite3_step(statement) == SQLITE_ROW)
		{
			Profile *profile = [[Profile alloc]init];
			
			char *name = (char*)sqlite3_column_text(statement, 1);
			char *password = (char*)sqlite3_column_text(statement, 2);
			char *safequestion = (char*)sqlite3_column_text(statement, 3);
			char *saferesult=(char*)sqlite3_column_text(statement, 4);
			char *company=(char*)sqlite3_column_text(statement, 6);
			
			profile.ID = sqlite3_column_int(statement, 0);
			profile.name = (name) ? [NSString stringWithUTF8String:name] : @"";
			profile.password = (password) ? [NSString stringWithUTF8String:password] : @"";
			profile.safeQuestion = (safequestion) ? [NSString stringWithUTF8String:safequestion] : @"";
			profile.safeResult = (saferesult) ? [NSString stringWithUTF8String:saferesult] : @"";
			
			int bytes1 = sqlite3_column_bytes(statement, 5);
			Byte *value1 = (Byte*)sqlite3_column_blob(statement, 5);
			if (bytes1 != 0 && value1 != NULL)
			{
				NSData * data = [NSData dataWithBytes:value1 length:bytes1];
				profile.headimage = [UIImage imageWithData:data];
				NSLog(@"image=%@---",profile.headimage);
				
			}
			profile.company = (company) ? [NSString stringWithUTF8String:company] : @"";
			
			int bytes2 = sqlite3_column_bytes(statement, 7);
			Byte *value2 = (Byte*)sqlite3_column_blob(statement, 7);
			if (bytes2 != 0 && value2 != NULL)
			{
				NSData * data = [NSData dataWithBytes:value2 length:bytes2];
				profile.fitmentImage = [UIImage imageWithData:data];
				NSLog(@"image=%@---",profile.headimage);
				
			}
			NSLog(@"name = %@",profile.name);
			getProfile = profile;

		}
		sqlite3_finalize(statement);
	}
	else
	{
		NSLog(@"Problem with the datebase:%d",sqlResult);
		getProfile = NULL;
	}
	return getProfile;
}

- (NSMutableArray*) getAllCompanys{

	NSMutableArray *companys = [[NSMutableArray alloc]init];
	const char *sql = "select * from companyTable";
	
	sqlite3_stmt *statement;
	
	int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
	if (sqlResult == SQLITE_OK)
	{
		while (sqlite3_step(statement) == SQLITE_ROW)
		{
			Company *company = [[Company alloc]init];
			
			char *name = (char*)sqlite3_column_text(statement, 1);
			char *adrress = (char*)sqlite3_column_text(statement, 2);
			char *information = (char*)sqlite3_column_text(statement, 3);
			char *phoneNumber=(char*)sqlite3_column_text(statement, 4);
			
			company.ID = sqlite3_column_int(statement, 0);
			company.name = (name) ? [NSString stringWithUTF8String:name] : @"";
			company.address = (adrress) ? [NSString stringWithUTF8String:adrress] : @"";
			company.infomation = (information) ? [NSString stringWithUTF8String:information] : @"";
			company.phoneNumber = (phoneNumber) ? [NSString stringWithUTF8String:phoneNumber] : @"";
			
			int bytes = sqlite3_column_bytes(statement, 5);
			Byte *value = (Byte*)sqlite3_column_blob(statement, 5);
			if (bytes != 0 && value != NULL)
			{
				NSData * data = [NSData dataWithBytes:value length:bytes];
				company.image = [UIImage imageWithData:data];
				NSLog(@"image=%@---",company.image);
				
			}
			company.praiser = sqlite3_column_int(statement, 6);
			company.works = sqlite3_column_int(statement, 7);
			company.form = sqlite3_column_int(statement, 8);
			company.pay = sqlite3_column_int(statement, 9);
			
			[companys addObject:company];
			
		}
		sqlite3_finalize(statement);
	}
	else
	{
		NSLog(@"Problem with the datebase:%d",sqlResult);
	}
	return companys;
}


@end
