//
//  DBAccess.h
//  fitment
//
//  Created by mac on 15/3/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Image.h"
#import "Profile.h"

@interface DBAccess : NSObject

- (NSMutableArray*) getAllProducts;
- (NSMutableArray*) getAllCompanys;
- (Profile*) getAllProfile:(NSString*)profileName;
- (void) closeDatabase;
- (void) initializeDatabase;

@end
