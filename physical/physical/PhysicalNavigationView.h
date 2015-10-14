//
//  PhysicalNavigationView.h
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PhysicalNavigationViewDelegate<NSObject>
- (void)previousToViewController;
@optional
- (void)rightButtonClickEvent;
@end

@interface PhysicalNavigationView : UIView
@property (nonatomic,assign) id<PhysicalNavigationViewDelegate>delegate;
@property (nonatomic,retain) UIImage *leftImage;
@property (nonatomic,retain) UIImage *headerImage;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,retain) UIImage *rightImage;
@property (nonatomic,assign) UIColor *navigaionBackColor;
@property (nonatomic) NSInteger type;

@end
