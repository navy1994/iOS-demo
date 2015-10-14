//
//  QuizTableViewCell.m
//  physical
//
//  Created by mac- t4 on 15/7/2.
//  Copyright (c) 2015年 mac- t4. All rights reserved.
//

#import "QuizTableViewCell.h"
#import "PhysicalPrefix.pch"
#import "DLRadioButton.h"

@implementation QuizTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 40)];
        _titleLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
//        self.resultSegment = [[UISegmentedControl alloc]initWithItems:@[@"根本不",@"很少",@"有时",@"经常",@"总是"]];
//        _resultSegment.frame = CGRectMake(5, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5, fDeviceWidth/2+60, 25);
//        _resultSegment.tintColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
//        [self.contentView addSubview:_resultSegment];
        //_radio1 = [[DLRadioButton alloc] initWithFrame:CGRectMake(30, 200, 200, 30)];
        
        _radio1 = [[DLRadioButton alloc] initWithFrame:CGRectMake(5, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5, 70, 25)];
        [_radio1 setTitle:@"根本不" forState:UIControlStateNormal];
        _radio1.buttonSideLength = 25;
        [_radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        _radio1.circleColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio1.indicatorColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_radio1];
        
        _radio2 = [[DLRadioButton alloc] initWithFrame:CGRectMake(80, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5, 60, 25)];
        [_radio2 setTitle:@"很少" forState:UIControlStateNormal];
        _radio2.buttonSideLength = 25;
        [_radio2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        _radio2.circleColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio2.indicatorColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_radio2];
        
        _radio3 = [[DLRadioButton alloc] initWithFrame:CGRectMake(145, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5, 60, 25)];
        _radio3.buttonSideLength = 25;
        [_radio3 setTitle:@"有时" forState:UIControlStateNormal];
        [_radio3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio3.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        _radio3.circleColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio3.indicatorColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_radio3];
        
        _radio4 = [[DLRadioButton alloc] initWithFrame:CGRectMake(210, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5, 60, 25)];
        _radio4.buttonSideLength = 25;
        [_radio4 setTitle:@"经常" forState:UIControlStateNormal];
        [_radio4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio4.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        _radio4.circleColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio4.indicatorColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_radio4];
        
        _radio5 = [[DLRadioButton alloc] initWithFrame:CGRectMake(275, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+5, 60, 25)];
        _radio5.buttonSideLength = 25;
        [_radio5 setTitle:@"总是" forState:UIControlStateNormal];
        [_radio5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio5.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        _radio5.circleColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio5.indicatorColor = [UIColor colorWithRed:125.0f/255.0f green:219.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
        _radio5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_radio5];
       
        
    }
    return self;
}

//#pragma mark ==== QRadioButtonDelegate
//- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
//    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
//    radio.checked = YES;
//    
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
