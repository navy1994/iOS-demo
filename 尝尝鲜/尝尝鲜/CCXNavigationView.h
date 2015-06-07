//
//  CCXNavigationView.h
//  尝尝鲜
//
//  Created by mac on 15/5/18.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCXNavigationViewDelegate <NSObject>
- (void)previousToViewController;
@optional
- (void)rightButtonClickEvent;
@end

@interface CCXNavigationView : UIView
@property (nonatomic,assign) id<CCXNavigationViewDelegate>delegate;
@property (nonatomic,retain) UIImage *leftImage;
@property (nonatomic,retain) UIImage *headerImage;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,retain) UIImage *rightImage;
@property (nonatomic,assign) UIColor *navigaionBackColor;
@property (nonatomic,strong) UISearchBar *seachBar;
@property (nonatomic) NSInteger type;

@end
