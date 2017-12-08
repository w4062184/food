//
//  LittleLifeCell.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/22.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "LittleLifeCell.h"

@implementation LittleLifeCell

- (void)showDataWithModel:(LittleLifeModel *)model{
    self.model = model;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:self.model.faceimg] placeholderImage:[UIImage imageNamed:@"littleLift"]];
    self.smallLabel.text = self.model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
