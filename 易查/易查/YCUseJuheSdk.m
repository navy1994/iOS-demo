//
//  YCUseJuheSdk.m
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCUseJuheSdk.h"
#import "JHAPISDK.h"

@implementation YCUseJuheSdk

static YCUseJuheSdk *_useJuhe;

+(YCUseJuheSdk *)shareUseJuhe{
	if (!_useJuhe) {
		_useJuhe = [[YCUseJuheSdk alloc]init];
	}
	return _useJuhe;
}

- (void)JuheAPI:(NSString*)path apiID:(NSString*)api_id parameters:(NSDictionary*)param method:(NSString*)method Block:(Block)block{
	self.block = block;
	JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
	[juheapi executeWorkWithAPI:path
						  APIID:api_id
					 Parameters:param
						 Method:method
						Success:^(id responseObject){
							if ([[param objectForKey:@"dtype"]isEqualToString:@"xml"]) {
								NSLog(@"****xml***\n %@",responseObject);
							}
							else{
								int error_code = [[responseObject objectForKey:@"error_code"] intValue];
								if (!error_code) {
									[self presentReqResult:responseObject];
									NSLog(@"real=%@",responseObject);
								}else{
									if (_tag == 1) {
										[self presentReqResult:responseObject];
										NSLog(@"commresult=%@",responseObject);
									}else{
										UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"信息有误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
										[alertView show];
									}
								}
								
							}
						} Failure:^(NSError *error){
							NSLog(@"error:%@",error.description);
					 }];
	
}

-(void)presentReqResult:(id)responseData{
	int resCode = [[responseData objectForKey:@"error_code"] intValue];
	if (resCode != 0) {
		NSLog(@"llllllllll");
		if (_tag == 1) {
				if ([responseData objectForKey:@"result"]) {
					if (self.block) {
						self.block([responseData objectForKey:@"result"]);
					}
					
				}else{
					UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"查不到哦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
					[alertView show];
				}

		}
		
	}else{
		
		if (self.block) {
			self.block([responseData objectForKey:@"result"]);
		}
    }
}

@end
