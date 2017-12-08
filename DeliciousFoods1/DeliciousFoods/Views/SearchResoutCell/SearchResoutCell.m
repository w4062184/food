//
//  SearchResoutCell.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "SearchResoutCell.h"

@implementation SearchResoutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSearchResoutModel:(SearchResoutModel *)timeModel{
    //取消 选中 效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.timeModel = timeModel;
    
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.timeModel.albums] placeholderImage:[UIImage imageNamed:@"homePlaceHoder"]];
    
    self.nameLabel.text = self.timeModel.title;
    self.foodLabel.text = self.timeModel.burden;
    self.BriefLabel.text = self.timeModel.imtro;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
