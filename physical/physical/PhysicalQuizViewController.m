//
//  PhysicalQuizViewController.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "PhysicalQuizViewController.h"
#import "PhysicalPrefix.pch"
#import "PhysicalNavigationView.h"
#import "QuizTableViewCell.h"
#import "ResultViewController.h"
#import "QuizDB.h"
#import "Quiz.h"

@interface PhysicalQuizViewController ()<PhysicalNavigationViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *_quizTableView;
    QuizDB *_dbQuiz;
    int step;
    int segmentTag;
    CGFloat height;
    NSUInteger sum;
    float originalScore;
    NSMutableDictionary *score1,*score2,*score3,*score4,*score5,*score6,*score7,*score8,*score9;
}
@property (strong, nonatomic) PhysicalNavigationView *navigation;
@property (strong, nonatomic) UIButton *homeBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) NSArray *stepArray;
@property (strong, nonatomic) NSMutableArray *tableTextArray;
@property (strong, nonatomic) NSMutableDictionary *scoreOfSum;

@end

@implementation PhysicalQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dbQuiz = [[QuizDB alloc]init];
    _scoreOfSum = nil;
    segmentTag = 1;
    //初始步为1，共9步
    step = 0;
    self.stepArray = @[@"qiyu",@"shire",@"deficiency",@"tanshi",@"tebin",@"xueyu",@"yinxu",@"yangxu",@"mild"];
    self.tableTextArray = [_dbQuiz getAllData:[_stepArray objectAtIndex:step]];
    sum = _tableTextArray.count;//初始化条目个数
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSString *system = [UIDevice currentDevice].systemVersion;
    float number = [system floatValue];
    
    height = 0.0f;
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
    
     _quizTableView = [[UITableView alloc]init];
    [_quizTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initTableView];

    self.homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _homeBtn.frame = CGRectMake(fDeviceWidth/2-90, fDeviceHeight-35, 80, 30);
    [_homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    _homeBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    [_homeBtn addTarget:self action:@selector(clickHomeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(fDeviceWidth/2+10, _homeBtn.frame.origin.y, 80, 30);
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    [_nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];

}

- (void)initTableView{
    _quizTableView.frame = CGRectMake(0, height, fDeviceWidth, fDeviceHeight-height-40);
    _quizTableView.dataSource = self;
    _quizTableView.delegate = self;
    _quizTableView.rowHeight = 80;
    [self.view addSubview:_quizTableView];
}

#pragma mark --- clickBtnEvent
- (void)clickNextBtn{
    if (step < 8) {
        step++;
        if (step > 0) {
            [_homeBtn setTitle:@"上一步" forState:UIControlStateNormal];
        }
        if(step == 8){
            [_nextBtn setTitle:@"查看结果" forState:UIControlStateNormal];
        }
    }else{
        ResultViewController *resultController = [[ResultViewController alloc]init];
        NSLog(@"score1=%@",score1);
        resultController.resultDictionary = _scoreOfSum;
        [self presentViewController:resultController animated:NO completion:NULL];
    }
    self.tableTextArray = [_dbQuiz getAllData:[_stepArray objectAtIndex:step]];
    sum += _tableTextArray.count;
    NSLog(@"selectStep:%d",step);
    NSLog(@"sum=%ld",sum);
    if (step == 4) {
        [self quizWithSex];
    }
    [self initTableView];
    [_quizTableView reloadData];
}

- (void)clickHomeBtn{
    if (step > 0) {
        step--;
        if (step == 0) {
            [_homeBtn setTitle:@"首页" forState:UIControlStateNormal];
        }else if(step != 8){
            [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:NULL];
    }
    sum -= _tableTextArray.count;//先让条目数减去当前步骤个数，再退回上一步
    self.tableTextArray = [_dbQuiz getAllData:[_stepArray objectAtIndex:step]];
    NSLog(@"selectStep:%d",step);
    NSLog(@"sum=%ld",sum);
    if (step == 4) {
        [self quizWithSex];
    }
    [self initTableView];
    [_quizTableView reloadData];
    NSLog(@"step%d=%@",step,[NSString stringWithFormat:@"step%d",step]);
}

- (void)quizWithSex{//根据性别对应测试题
        if (_selectRex == 6) {
            [_tableTextArray removeObjectAtIndex:_selectRex-1];
        }else{
            [_tableTextArray removeObjectAtIndex:_selectRex+1];
        }
}

#pragma mark --- PhysicalNavigationDelegate
- (void)previousToViewController{
    [self dismissViewControllerAnimated:NO completion:NULL];
}

- (void)rightButtonClickEvent{
    
}

#pragma mark ----- UITableViewDatabase
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableTextArray.count;
}


- (QuizTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndetifier = @"cell";
    QuizTableViewCell *cell = (QuizTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIndetifier];
    
    if (!cell) {
        cell = [[QuizTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
    }
    Quiz *quiz = [[Quiz alloc]init];
    quiz = [self.tableTextArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@" %ld.%@",indexPath.row+1,quiz.quiz];
    [cell.radio1 addTarget:self action:@selector(clickRadio:) forControlEvents:UIControlEventEditingChanged];
    [cell.radio1 addTarget:self action:@selector(clickRadio:) forControlEvents:UIControlEventEditingChanged];
    [cell.radio1 addTarget:self action:@selector(clickRadio:) forControlEvents:UIControlEventEditingChanged];
    [cell.radio1 addTarget:self action:@selector(clickRadio:) forControlEvents:UIControlEventEditingChanged];
    [cell.radio1 addTarget:self action:@selector(clickRadio:) forControlEvents:UIControlEventEditingChanged];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"第%d步/共9步",step+1];
}


//#pragma mark ==== QRadioButtonDelegate
//- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
//    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
//    radio.checked = YES;
//}

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
