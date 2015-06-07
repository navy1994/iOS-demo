//
//  HomeViewController.m
//  fitment
//
//  Created by mac on 15/3/4.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "HomeViewController.h"
#import "DBAccess.h"
#import "Image.h"
#import "NavigationBar.h"
#import "DetailCaseViewController.h"
#import "FitmentPrefix.pch"

@interface HomeViewController ()

@end

@implementation HomeViewController
- (void)viewDidLoad {

	DBAccess *dbAccess = [[DBAccess alloc]init];
	self.image = [dbAccess getAllProducts];
	
	dbCase = [[CaseDB alloc]init];
	self.cases = [dbCase getAllData];

	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//设置导航栏内容
	[navigationItem setTitle:@"主页"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
	float AD_height = 150;//广告栏高度
	UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+60);//头部
	self.aCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65, fDeviceWidth, fDeviceHeight + 65) collectionViewLayout:flowLayout];
	
	//设置代理
	self.aCollectionView.delegate = self;
	self.aCollectionView.dataSource = self;
	[self.view addSubview:self.aCollectionView];
	
	
	
	self.aCollectionView.backgroundColor = [UIColor whiteColor];
	
	//注册cell和ReusableView（相当于头部）
	[self.aCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
	
	
	/*
	 ***广告栏
	 */
	_headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, AD_height)];
	_headerView.backgroundColor = [UIColor blackColor];
	
	/*
	 ***加载的数据
	 */
	DBAccess *db = [[DBAccess alloc]init];
	self.headViewImage = [db getAllProducts];
	self.imgArray = [[NSMutableArray alloc]init];
	
	for (int i = 0; i < 6; i++) {
		int ret = rand()%64;
		Image *image = [self.headViewImage objectAtIndex:ret];
		[self.imgArray addObject:image.Image];
	}
	
	[_headerView setArray:self.imgArray];
	
    [super viewDidLoad];
    // Do any additional setup after loading the view.ß
	
}


#pragma mark 定时滚动scrollView
-(void)viewDidAppear:(BOOL)animated{//显示窗口
	[super viewDidAppear:animated];
	//    [NSThread sleepForTimeInterval:3.0f];//睡眠，所有操作都不起作用
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[_headerView openTimer];//开启定时器
	});
}
-(void)viewWillDisappear:(BOOL)animated{//将要隐藏窗口  setModalTransitionStyle=UIModalTransitionStyleCrossDissolve时是不隐藏的，故不执行
	[super viewWillDisappear:animated];
	if (_headerView.totalNum>1) {
		[_headerView closeTimer];//关闭定时器
	}
}
#pragma mark - scrollView也是适用于tableView的cell滚动 将开始和将要结束滚动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	[_headerView closeTimer];//关闭定时器
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
	if (_headerView.totalNum>1) {
		[_headerView openTimer];//开启定时器
	}
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 4;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cell";
	CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	[cell sizeToFit];
	if (!cell) {
		NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
	}
	if (indexPath.row < 3) {
		Image *image = [self.image objectAtIndex:rand()%49];
		cell.imgview.image = image.Image;
		
		self.aCase = [self.cases objectAtIndex:indexPath.row];
		UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 200, 200, 30)];
		nameLabel.text = self.aCase.name;
		nameLabel.textColor = [UIColor whiteColor];
		nameLabel.font = [UIFont boldSystemFontOfSize:14];
		[cell.imgview addSubview:nameLabel];
	}		
	
	return cell;
}
//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
		UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
												UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
		
		[headerView addSubview:_headerView];//头部广告栏
		return headerView;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//边距占5*4=20 ，2个
	//图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
	return CGSizeMake(fDeviceWidth, (fDeviceWidth-20)/2+50);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	Image *image = [self.image objectAtIndex:indexPath.row];
	DetailCaseViewController *detailViewController = [[DetailCaseViewController alloc]init];
	detailViewController.image = image.Image;
	detailViewController.indexRow = indexPath.row;
	NSLog(@"选择%ld",indexPath.row);
	[self presentViewController:detailViewController animated:NO completion:NULL];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
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
