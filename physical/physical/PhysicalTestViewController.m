//
//  PhysicalTestViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "PhysicalTestViewController.h"
#import "PhysicalNavigationView.h"
#import "PhysicalTestHomeView.h"
#import "PhysicalPrefix.pch"
#import "PhysicalQuizViewController.h"

@interface PhysicalTestViewController ()<PhysicalNavigationViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *_ageTableView;
    int selectSex;
}
@property (strong, nonatomic) PhysicalNavigationView *navigation;
@property (strong, nonatomic) PhysicalTestHomeView *homeView;
@property (strong, nonatomic) NSArray *ageArray;

@end

@implementation PhysicalTestViewController

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
    _navigation.title = @"体质测试";
    _navigation.navigaionBackColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    _navigation.leftImage = [UIImage imageNamed:@"nav_chbackbtn.png"];
    _navigation.type = type;
    _navigation.delegate = self;
    _navigation.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigation];
    
    self.homeView = [[PhysicalTestHomeView alloc]initWithFrame:CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height)];
    [_homeView.ageBtn addTarget:self action:@selector(clickAgeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeView];
    [_homeView.startTestBtn addTarget:self action:@selector(clickStartTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [_homeView.sexSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    _ageTableView = [[UITableView alloc]initWithFrame:CGRectMake(_homeView.ageBtn.frame.origin.x, _homeView.ageBtn.frame.origin.y, _homeView.ageBtn.frame.size.width, 60)];
    _ageTableView.dataSource = self;
    _ageTableView.delegate = self;
    _ageTableView.rowHeight = 20;
    [_ageTableView setHidden:YES];
    [self.homeView addSubview:_ageTableView];
    
    self.ageArray = @[@"20岁以下",@"20-35岁",@"35-45岁",@"45-55岁",@"55-65岁",@"65岁以上"];
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
            
        case 0:
            selectSex = 6;//男性
            break;
            
        case 1:
            selectSex = 5;//女性
            break;
        default:
            
            break;
            
    }
    
}

#pragma mark --- PhysicalNavigationDelegate
- (void)previousToViewController{
    
}

- (void)rightButtonClickEvent{
    
}

- (void)clickAgeBtn{
    [_ageTableView setHidden:NO];
}

- (void)clickStartTestBtn{
    PhysicalQuizViewController *quizViewController = [[PhysicalQuizViewController alloc]init];
    quizViewController.selectRex = selectSex;
    [self presentViewController:quizViewController animated:NO completion:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndetifier = @"cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIndetifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
    }
    
    cell.textLabel.text = [_ageArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _homeView.ageResultLabel.text = [_ageArray objectAtIndex:indexPath.row];
    [_ageTableView setHidden:YES];
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
