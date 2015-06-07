//
//  UseJuhe.m
//  笑话大全
//
//  Created by mac on 15/6/6.
//  Copyright (c) 2015年 李海军. All rights reserved.
//

#import "UseJuhe.h"

@implementation UseJuhe
static UseJuhe *_useJuhe;

+(UseJuhe *)shareUseJuhe{
	if (!_useJuhe) {
		_useJuhe = [[UseJuhe alloc]init];
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
									//NSLog(@"real=%@",responseObject);
								}else{
									
									//NSLog(@"commreObject=%@",responseObject);
								}
								
							}
						} Failure:^(NSError *error){
							NSLog(@"error:%@",error.description);
					 }];
	
}

-(void)presentReqResult:(id)responseData{
	int resCode = [[responseData objectForKey:@"error_code"] intValue];
	//NSLog(@"---------------\n%@",responseData);
	if (resCode == 0) {
		if (self.block) {
			self.block([responseData objectForKey:@"result"]);
		}
	}
}

@end
