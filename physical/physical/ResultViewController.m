//
//  ResultViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/3.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "ResultViewController.h"
#import "PhysicalPrefix.pch"
#import "PhysicalNavigationView.h"
#import "PhysicalTestViewController.h"

@interface ResultViewController ()<PhysicalNavigationViewDelegate>{
    float sumScore;
}
@property (strong, nonatomic) PhysicalNavigationView *navigation;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSString *system = [UIDevice currentDevice].systemVersion;
    float number = [system floatValue];
    
    CGFloat height = 0.0f;
    NSInteger type = 0;
    if (number <= 6.9) {
        type = 0;
        height = 44.0f;
    }else{
        type = 1;
        height = 66.0f;
    }
    
    self.navigation = [[PhysicalNavigationView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, height)];
    _navigation.title = @"测试结果";
    _navigation.navigaionBackColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    _navigation.leftImage = [UIImage imageNamed:@"nav_chbackbtn.png"];
    _navigation.type = type;
    _navigation.delegate = self;
    _navigation.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigation];
    NSLog(@"dic=%@",_resultDictionary);
    long sum = [_resultDictionary count];
    NSArray *allScore = [_resultDictionary allValues];
    for (int i=0; i < allScore.count; i++) {
        NSNumber *score = [allScore objectAtIndex:i];
        sumScore += [score floatValue];
    }
    float zhuanHuaScore = (sumScore-sum)/(sum*4)*100;
    
    //计算其他八
}

#pragma mark ---- PhysicalNavigationViewDelegate
- (void)previousToViewController{
    PhysicalTestViewController *testController = [[PhysicalTestViewController alloc]init];
    [self presentViewController:testController animated:NO completion:NULL];
}

- (void)rightButtonClickEvent{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
