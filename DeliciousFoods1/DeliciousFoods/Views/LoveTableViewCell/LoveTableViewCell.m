//
//  LoveTableViewCell.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/24.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "LoveTableViewCell.h"

@implementation LoveTableViewCell

- (void)showDataWithModel:(DetailModel *)model{
    self.model = model;
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.model.albums] placeholderImage:[UIImage imageNamed:@"homePlaceHoder"]];
    self.foodName.textColor = Kcolor(230, 180, 180);
    self.foodName.text = self.model.title;

}

- (void)showDataWithArray:(NSArray *)arr withNumber:(NSInteger)num{
    
    self.foodImageView.image = [UIImage imageNamed:arr[num]];
    self.foodName.textColor = Kcolor(230, 180, 180);
    self.foodName.text = arr[num];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
