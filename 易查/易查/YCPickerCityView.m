//
//  YCPickerCityView.m
//  易查
//
//  Created by mac on 15/5/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCPickerCityView.h"
#import "PrefixHeader.pch"
#import "YCWeatherViewController.h"
#import "JHAPISDK.h"
#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
@interface YCPickerCityView ()
@property(nonatomic,retain)NSDictionary* dict;
@property(nonatomic,retain)NSArray* pickerArray;
@property(nonatomic,retain)NSArray* subPickerArray;
@property(nonatomic,retain)NSArray* thirdPickerArray;
@property(nonatomic,retain)NSArray* selectArray;

@end

@implementation YCPickerCityView
@synthesize dict=_dict;
@synthesize pickerArray=_pickerArray;
@synthesize subPickerArray=_subPickerArray;
@synthesize thirdPickerArray=_thirdPickerArray;
@synthesize selectArray=_selectArray;




-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor groupTableViewBackgroundColor];
		self.pickerCity = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		_pickerCity.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//这里设置了就可以自定义高度了，一般默认是无法修改其216像素的高度
		_pickerCity.showsSelectionIndicator = YES;
		_pickerCity.delegate = self;
		_pickerCity.dataSource = self;
		[self addSubview:_pickerCity];
		
		NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
		_dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
		self.pickerArray=[_dict allKeys];
		self.selectArray=[_dict objectForKey:[[_dict allKeys] objectAtIndex:0]];
		
		if ([_selectArray count]>0) {
			self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
		}
		if ([_subPickerArray count]>0) {
			self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
			NSLog(@"%@",[self.subPickerArray objectAtIndex:0]);
		}

		
	}
	return self;
}

#pragma mark --
#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (component==FirstComponent) {
		return [self.pickerArray count];
	}
	if (component==SubComponent) {
		return [self.subPickerArray count];
	}
	if (component==ThirdComponent) {
		return [self.thirdPickerArray count];
	}
	return 0;
}


#pragma mark--
#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (component==FirstComponent) {
		return [self.pickerArray objectAtIndex:row];
	}
	if (component==SubComponent) {
		return [self.subPickerArray objectAtIndex:row];
	}
	if (component==ThirdComponent) {
		return [self.thirdPickerArray objectAtIndex:row];
	}
	return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSLog(@"row is %ld,Component is %ld",row,component);
	if (component==0) {
		self.selectArray=[_dict objectForKey:[self.pickerArray objectAtIndex:row]];
		if ([self.selectArray count]>0) {
			self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
		}else{
			self.subPickerArray=nil;
		}
		if ([self.subPickerArray count]>0) {
			self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
		}else{
			self.thirdPickerArray=nil;
		}
		[pickerView selectedRowInComponent:1];
		[pickerView reloadComponent:1];
		[pickerView selectedRowInComponent:2];
		
		
	}
	if (component==1) {
		if ([_selectArray count]>0&&[_subPickerArray count]>0) {
			self.thirdPickerArray=[[self.selectArray objectAtIndex:0]
								   objectForKey:[self.subPickerArray objectAtIndex:row]];
			
		}else{
			self.thirdPickerArray=nil;
		}
		[pickerView selectRow:0 inComponent:2 animated:YES];
		
	}
	if (component == 2) {
		if (_thirdPickerArray.count > 0) {
			NSLog(@"self.picke = %@",[self.thirdPickerArray objectAtIndex:row]);
			_cityName = [_thirdPickerArray objectAtIndex:row];
			NSString *path = @"http://op.juhe.cn/onebox/weather/query";
			NSString *api_id = @"73";
			NSString *method = @"GET";
			NSDictionary *param = @{@"cityname":[self.thirdPickerArray objectAtIndex:row],@"dtype":@"json"};
			
			[self JuheAPI:path apiID:api_id parameters:param method:method];

		}
	}
	
	
	[pickerView reloadComponent:2];
	
}

- (void)JuheAPI:(NSString*)path apiID:(NSString*)api_id parameters:(NSDictionary*)param method:(NSString*)method{
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
									NSLog(@"%@",responseObject);
									[self presentReqResult:responseObject];
									
								}else{
									NSLog(@"%@",responseObject);
								}
								
							}
						} Failure:^(NSError *error){
							NSLog(@"error:%@",error.description);
					 }];
	
}

-(void)presentReqResult:(id)responseData{
	int resCode = [[responseData objectForKey:@"error_code"] intValue];
	if (resCode != 0) {
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"报错" message:[responseData objectForKey:@"reason"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alertView show];
	}else{
		YCWeatherViewController * weatherVC = [[YCWeatherViewController alloc]init];
		NSDictionary *jsonResult = [responseData objectForKey:@"result"];
		weatherVC.jsonResult = jsonResult;
		weatherVC.selectCity = _cityName;
		NSLog(@"jsonResult:%@",jsonResult);
		//result = jsonResult;
		[_parentVC presentViewController:weatherVC animated:NO completion:NULL];
	}
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
	
	UILabel *myView = nil;
	
	if (component == 0) {
		
		myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, (fDeviceWidth*2/3-10.0f)/3, 20)];
		
		myView.textAlignment = NSTextAlignmentCenter;
		
		myView.text = [_pickerArray objectAtIndex:row];
		
		myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
		
		myView.backgroundColor = [UIColor clearColor];
		
	}else if(component == 1){
		
		myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, (fDeviceWidth*2/3-10.0f)/3, 20)];
		
		myView.text = [_subPickerArray objectAtIndex:row];
		
		myView.textAlignment = NSTextAlignmentCenter;
		
		myView.font = [UIFont systemFontOfSize:13];
		
		myView.backgroundColor = [UIColor clearColor];
		
	}else{
		myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, (fDeviceWidth*2/3-10.0f)/3, 20)];
		
		myView.text = [_thirdPickerArray objectAtIndex:row];
		
		myView.textAlignment = NSTextAlignmentCenter;
		
		myView.font = [UIFont systemFontOfSize:11];
		
		myView.backgroundColor = [UIColor clearColor];

	}
	
	return myView;
	
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	if (component==FirstComponent) {
		return (fDeviceWidth*2/3-10.0f)/3;
	}
	if (component==SubComponent) {
		return (fDeviceWidth*2/3-10.0f)/3;
	}
	if (component==ThirdComponent) {
		return (fDeviceWidth*2/3-10.0f)/3;
	}
	return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 20;
}




@end
