//
//  CCXHomeViewController.m
//  尝尝鲜
//
//  Created by mac on 15/5/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "CCXHomeViewController.h"
#import "CookbookViewController.h"
#import "SortMenuViewController.h"
#import "SearchMenuViewController.h"
#import "CCXDeatilViewController.h"
#import "JHAPISDK.h"
#import "CCXUseJuhe.h"
#import "UIImageView+WebCache.h"

@interface CCXHomeViewController ()

@property (nonatomic,strong) NSArray *data;
@end

@implementation CCXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_useJuhe = [CCXUseJuhe shareUseJuhe];
	[self useJuheGetJSON];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"尝尝鲜";
	
	self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, self.navigation.size.height+self.navigation.origin.y, self.view.size.width, 60.0f)];
	_searchBar.delegate = self;
	_searchBar.placeholder = @"搜索菜谱";
	_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.keyboardType = UIKeyboardTypeDefault;
	[self.view addSubview:_searchBar];
	
	NSLog(@"class%@",_classifyArray);
	
	UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
	searchButton.frame = _searchBar.frame;
	searchButton.backgroundColor = [UIColor clearColor];
	[searchButton addTarget:self action:@selector(clickButtonToSearch) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:searchButton];
	
	float AD_height = 160.0f;
	UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	//flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+60);//头部
	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _searchBar.frame.origin.y+_searchBar.frame.size.height, fDeviceWidth, fDeviceHeight - 65) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	[self.view addSubview:_collectionView];
	
	//注册cell和ReusableView（相当于头部）
	[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
	/*
	 ***广告栏
	 */
	_headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(0, 5, fDeviceWidth, AD_height+60)];
	
	/*
	 ***加载的数据
	 */
	UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
	headerButton.frame = _headerView.frame;
	headerButton.backgroundColor = [UIColor clearColor];
	[headerButton addTarget:self action:@selector(clickButtonToHeader) forControlEvents:UIControlEventTouchUpInside];
	[_headerView addSubview:headerButton];
	//注册
	[SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
	[SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
	//设定图片存储顺序
	[SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
	SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;

}

- (void)flushCache
{
	[SDWebImageManager.sharedManager.imageCache clearMemory];
	[SDWebImageManager.sharedManager.imageCache clearDisk];
}

- (void)clickButtonToHeader{
	CCXDeatilViewController *detailController = [[CCXDeatilViewController alloc]init];
	int ret = rand()%_data.count;
	detailController.detailDic = [_data objectAtIndex:ret];
	[self presentViewController:detailController animated:NO completion:NULL];
}


#pragma mark----getJSON
- (void)useJuheGetJSON{
	[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/category" apiID:@"46" parameters:@{@"dtype":@"json"} method:@"get" Block:^(id result){
		if (result) {
			//NSLog(@"result=%@",result);
			[self getResult:result];
		}
	}];
}

- (void)getResult:(id)resultData{
	self.classifyArray = resultData;
	//NSLog(@"%@",_classifyArray);
	[_collectionView reloadData];
		int ret = rand()% _classifyArray.count;
		[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/index" apiID:@"46" parameters:@{@"cid":[[[[_classifyArray objectAtIndex:ret]objectForKey:@"list"]objectAtIndex:2]objectForKey:@"id"],@"dtype":@"json"} method:@"get" Block:^(id result){
			if (result) {
				[self initAdvertisingColumn:result];
			}
		}];
	
}

- (void)initAdvertisingColumn:(id)resultData{
   self.data = [resultData objectForKey:@"data"];
	NSMutableArray *_imgArray = [[NSMutableArray alloc]init];
	for (int i = 0; i < 6; i++) {
		int ret = rand()%_data.count;
		UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[[_data objectAtIndex:ret]objectForKey:@"albums"]objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
		[_imgArray addObject:image];
	}
	[_headerView setArray:_imgArray];

}

- (void)clickButtonToSearch{
	SearchMenuViewController *searchController = [[SearchMenuViewController alloc]init];
	int flag = rand()%_classifyArray.count;
	searchController.hotSearchArray = [[_classifyArray objectAtIndex:flag]objectForKey:@"list"];
	searchController.isFirstSearch = YES;
	[self presentViewController:searchController animated:NO completion:NULL];
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
	if (section == 1) {
		return 9;
	}else if(section == 0){
		return 1;
	}else{
		return 3;
	}
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 3;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identify = @"cell";
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
	for (UIView *view in cell.contentView.subviews) {
		if (view) {
			[view removeFromSuperview];
		}
	}
	[cell sizeToFit];
	if (!cell) {
		cell = [[UICollectionViewCell alloc]init];
		NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
	}
	
	switch (indexPath.section) {
       case 0:
			//cell.contentView.backgroundColor = [UIColor greenColor];
			[cell.contentView addSubview:_headerView];
			break;
       case 1:
	        cell.backgroundColor = [UIColor whiteColor];
			if (indexPath.row == 0) {
				UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,fDeviceWidth-10, (fDeviceWidth-25)/8)];
				aLabel.text = @"菜谱分类";
				[cell.contentView addSubview:aLabel];
			}else{
				UILabel *classifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, (fDeviceWidth-25)/4-4, (fDeviceWidth-25)/8-10)];
				classifyLabel.textAlignment = NSTextAlignmentCenter;
				if (indexPath.row<8) {
					classifyLabel.text = [[[[_classifyArray objectAtIndex:0]objectForKey:@"list"]objectAtIndex:indexPath.row]objectForKey:@"name"];
				}else{
					classifyLabel.text = [NSString stringWithFormat:@"更多>>"];
				}
				[cell.contentView addSubview:classifyLabel];
			}
			break;
	   case 2:{
		   NSLog(@"row=%ld",indexPath.row);
		   cell.backgroundColor = [UIColor whiteColor];
		   UIImageView *imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, (fDeviceWidth-20)/2+40)];
		   [imgeView sd_setImageWithURL:[NSURL URLWithString:[[[[_data objectAtIndex:indexPath.row]objectForKey:@"albums"]objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
	   placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
		   [cell.contentView addSubview:imgeView];
		   UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, 30)];
		   title.text = [[_data objectAtIndex:indexPath.row]objectForKey:@"title"];
		   title.textAlignment = NSTextAlignmentLeft;
		   title.font = [UIFont boldSystemFontOfSize:26];
		   [imgeView addSubview:title];
	   }
			break;
  default:
			break;
	}
	
	return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//边距占5*4=20 ，2个
	//图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			return CGSizeMake(fDeviceWidth-10, (fDeviceWidth-25)/8);
		}else{
			return CGSizeMake((fDeviceWidth-25)/4, (fDeviceWidth-25)/8);
		}
	}else{
		return CGSizeMake(fDeviceWidth, (fDeviceWidth-20)/2+50);
	}
	
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(0, 5, 20, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	return 5;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section) {
       case 0:
			break;
	   case 1:
			if (indexPath.row<8) {
				[_useJuhe JuheAPI:@"http://apis.juhe.cn/cook/index" apiID:@"46" parameters:@{@"cid":[[[[_classifyArray objectAtIndex:0]objectForKey:@"list"]objectAtIndex:indexPath.row]objectForKey:@"id"],@"dtype":@"json"} method:@"get" Block:^(id result){
					if (result) {
						[self presentController:result didSelectItemAtIndexPath:indexPath];
					}
				}];
			}else{
				[self presentController:nil didSelectItemAtIndexPath:indexPath];
			}
			break;
	   case 2:
	   {
		   CCXDeatilViewController *detailController = [[CCXDeatilViewController alloc]init];
		   detailController.detailDic = [_data objectAtIndex:indexPath.row];
		   [self presentViewController:detailController animated:NO completion:NULL];
	   }
			break;
	 default:
			break;
	}
}

- (void)presentController:(id)resultData didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	SortMenuViewController *sortMenuController = [[SortMenuViewController alloc]init];
	sortMenuController.data = _classifyArray;
	if (indexPath.row < 8) {
		sortMenuController.isClassity = NO;
		sortMenuController.currentData1Index = 1;
		sortMenuController.currentData1SelectedIndex = indexPath.row;
		sortMenuController.menuData = [resultData objectForKey:@"data"];
		sortMenuController.selectMenu = [[[[_classifyArray objectAtIndex:0]objectForKey:@"list"]objectAtIndex:indexPath.row]objectForKey:@"name"];
	}else{
		sortMenuController.isClassity = YES;
	}
    [self presentViewController:sortMenuController animated:NO completion:NULL];
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


@end
