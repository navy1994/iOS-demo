//
//  YCLayoutView.h
//  易查
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCLayoutView : UIView<UISearchBarDelegate>{
	UIImageView *_imageView;
	UILabel *_mainLabel;
	UISearchBar *_seachBar;
	BOOL clickBtn;
}

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *mainLabel;
@property(nonatomic,strong) UISearchBar *seachBar;
@property(nonatomic,strong) UIButton *changViewBtn;
@property(nonatomic,strong) UITextField *numberTF;
@property(nonatomic,strong) UIViewController *rootConteoller;
@property(nonatomic,strong) UIView *aView;

- (id)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;
@end
