//
//  DetailViewController.h
//  fitment
//
//  Created by mac on 15/3/21.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveImage.h"
#import "SaveImageDB.h"

@interface DetailViewController : UIViewController{
	SaveImageDB *dbSaveImage;
}

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *aToolBar;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSInteger indexRow;
@property (nonatomic,strong) SaveImage *saveImage;

- (void) clickCollectImage;
- (void) clickShareImage:(id)sender;
- (void) clickButtonBackToImage;
- (void) clickButtonToSave;
@end
