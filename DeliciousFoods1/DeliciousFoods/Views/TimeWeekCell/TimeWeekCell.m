//
//  TimeWeekCell.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "TimeWeekCell.h"
#import "TimeDeliciousModel.h"

@implementation TimeWeekCell

- (void)setTimeDeliciousModel:(TimeDeliciousModel *)timeModel{
    
    self.timeModel = timeModel;
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.timeModel.picture_url] placeholderImage:[UIImage imageNamed:@"homePlaceHoder"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.timeModel.user_image] placeholderImage:[UIImage imageNamed:@"homeUserImage"]];
    self.titleNameLabel.text = [NSString stringWithFormat:@"%@",self.timeModel.food_name];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.timeModel.publish_time];
    self.sceneLabel.text = [NSString stringWithFormat:@"%@:%@",@"餐厅",self.timeModel.place_name];
    self.sceneLabel.adjustsFontSizeToFitWidth = YES;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@",self.timeModel.user_name];
    self.userNameLabel.adjustsFontSizeToFitWidth = YES;
    self.whereLabel.text = [NSString stringWithFormat:@"%@:%@",@"城市",self.timeModel.city_name];
    
}

//- (void)settingData{
//    
//    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.timeModel.picture_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.timeModel.user_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    self.titleNameLabel.text = self.timeModel.food_name;
//    self.timeLabel.text = self.timeModel.publish_time;
//    self.sceneLabel.text = self.timeModel.place_name;
//    self.userNameLabel.text = self.timeModel.user_name;
//
//}


- (void)awakeFromNib {
    // Initialization code
}

@end
