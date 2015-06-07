//
//  YCLayoutView.m
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "YCLayoutView.h"
#import "YCCommodityViewController.h"
#import "YCUseJuheSdk.h"
#import "PrefixHeader.pch"
#import "YCExpressViewController.h"
#import "ExpressCompanyView.h"

@interface YCLayoutView (){
	YCUseJuheSdk *useJuhe;
}
@property(nonatomic,strong) UIButton *chooseExpressBtn;
@property(nonatomic,strong) UILabel *expressLabel;
@end

@implementation YCLayoutView
@synthesize imageView = _imageView;
@synthesize mainLabel = _mainLabel;
@synthesize seachBar = _seachBar;

- (id)initWithFrame:(CGRect)frame withTag:(NSInteger)tag{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor groupTableViewBackgroundColor];
		self.aView = [[UIView alloc]initWithFrame:self.frame];
		_aView.backgroundColor = [UIColor clearColor];
		[self addSubview:_aView];
		_mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 30)];
		_mainLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_mainLabel];
		_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80, self.frame.size.width-60, self.frame.size.width-60)];
		[_imageView setBackgroundColor:[UIColor redColor]];
		[self addSubview:_imageView];
		_seachBar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, _imageView.frame.origin.y+_imageView.frame.size.height+20, self.frame.size.width-10, 30)];
		_seachBar.delegate = self;
		_seachBar.tag = tag;
		_seachBar.showsCancelButton = YES;
		_seachBar.backgroundColor = [UIColor clearColor];
		_seachBar.barTintColor = [UIColor groupTableViewBackgroundColor];
		_seachBar.alpha = 0.5;
		[self addSubview:_seachBar];
		[self initDifferentWithCell];
		
		UIButton *cancelButton;
		UIView *topView = _seachBar.subviews[0];
		for (UIView *subView in topView.subviews) {
			if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
				cancelButton = (UIButton*)subView;
			}
		}
		if (cancelButton) {
			//Set the new title of the cancel button
			[cancelButton setTitle:@"确定" forState:UIControlStateNormal];
			[cancelButton setTitleColor:[UIColor colorWithRed:53.f/255.f green:114.f/255.f blue:255.f/255.f alpha:1.0] forState:UIControlStateNormal];
			cancelButton.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:15];
		}
	
	useJuhe = [YCUseJuheSdk shareUseJuhe];
	}
	return self;
}


- (void)initDifferentWithCell{
	switch (_seachBar.tag) {
        case 0:
			break;
		case 1:
		{
			self.expressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, fDeviceWidth*5/6+60, fDeviceWidth*5/6-50, 30)];
			_expressLabel.text = @"选择快递";
			_expressLabel.textAlignment = NSTextAlignmentCenter;
			_expressLabel.font = [UIFont boldSystemFontOfSize:15];
			[self addSubview:_expressLabel];
			self.chooseExpressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			_chooseExpressBtn.frame = CGRectMake(20, fDeviceWidth*5/6+60, fDeviceWidth*5/6-50, 30);
			_chooseExpressBtn.backgroundColor = [UIColor clearColor];
			[_chooseExpressBtn addTarget:self action:@selector(clickBtnChooseExpress) forControlEvents:UIControlEventTouchUpInside];
			clickBtn = NO;
			[self addSubview:_chooseExpressBtn];

		}
			break;
  default:
			break;
	}
}

- (void)clickBtnChooseExpress{
	
	ExpressCompanyView *expressCompanyView = [[ExpressCompanyView alloc]initWithFrame:CGRectMake((fDeviceWidth*5/6-10)/4, fDeviceWidth*5/6+90,(fDeviceWidth*5/6-10)/2, fDeviceHeight*5/6-40-(fDeviceWidth*5/6+65)) Block:^(NSString *str){
		_expressLabel.text = str;
		NSLog(@"expressName%@",str);
	}];
    [self addSubview:expressCompanyView];
//	if (!clickBtn) {
//		[expressCompanyView setHidden:NO];
//		clickBtn = YES;
//	}
//	else{
//        [expressCompanyView setHidden:YES];
//		clickBtn = NO;
//	}
}


#pragma mark -- UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	switch (_seachBar.tag) {
        case 0:
			break;
		case 1:
		{
		    NSDictionary *expressDic = @{@"EMS":@"ems",@"圆通":@"yt",@"顺丰":@"sf",@"申通":@"sto",@"韵达":@"yd",@"天天":@"tt",@"中通":@"zto"};
			NSLog(@"_expresstext=%@,danhao=%@",[expressDic objectForKey:_expressLabel.text],_seachBar.text);
			if ([expressDic objectForKey:_expressLabel.text] && _seachBar.text) {
				[useJuhe JuheAPI:@"http://v.juhe.cn/exp/index" apiID:@"43" parameters:@{@"com":[expressDic objectForKey:_expressLabel.text],@"no":_seachBar.text,@"dtype":@"json"} method:@"get" Block:^(id result){
					[self presentReqResult:result];
					NSLog(@"result=%@",result);
				}];
			}else{
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"快递公司和单号不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
				[alertView show];
			}

		}
			break;
		case 2:
		{
			if (_seachBar.text) {
			     useJuhe.tag = 1;
				[useJuhe JuheAPI:@"http://api2.juheapi.com/mmb/search/simple" apiID:@"137" parameters:@{@"keyword":_seachBar.text,@"dtype":@"json"} method:@"get" Block:^(id result){
					NSLog(@"commodityResult=%@",result);
					if (result) {
						[self presentReqResult:result];
					}
					else{
						UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请求错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
						[alertView show];

					}
				}];

			}else{
				UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"商品不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
				[alertView show];

			}
		}
			break;
		case 3:
			break;
  default:
			break;
	}
	
}

-(void)presentReqResult:(id)responseData{
	if (responseData) {
		switch (_seachBar.tag) {
			case 0:
                break;
			case 1:
			{
				if ([responseData objectForKey:@"list"]) {
					YCExpressViewController *expressVC = [[YCExpressViewController alloc]init];
					expressVC.resultDic = responseData;
					[self.rootConteoller presentViewController:expressVC animated:NO completion:NULL];
				}else{
					NSLog(@"list-------%@",[responseData objectForKey:@"list"]);
					UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"单号和快递公司有误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
					[alertView show];
				}
				
				
			}
				break;
			case 2:
			{
				YCCommodityViewController *commodityVC = [[YCCommodityViewController alloc]init];
				commodityVC.resultArray = responseData;
				NSLog(@"responseData=%@",responseData);
				[self.rootConteoller presentViewController:commodityVC animated:NO completion:NULL];
			}
				break;
			default:
    break;
		}
		
	}
}



@end
