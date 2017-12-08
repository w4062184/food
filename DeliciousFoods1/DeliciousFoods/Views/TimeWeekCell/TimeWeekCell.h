//
//  TimeWeekCell.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeDeliciousModel;

@interface TimeWeekCell : UICollectionViewCell

- (void)setTimeDeliciousModel:(TimeDeliciousModel *)timeModel;

@property (nonatomic,strong)TimeDeliciousModel *timeModel;

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *whereLabel;



@end
