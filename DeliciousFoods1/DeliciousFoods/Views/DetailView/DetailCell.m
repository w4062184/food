//
//  DetailCell.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/19.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)showDataWithArray:(NSDictionary *)imageDict{
    NSString *imageUrl = imageDict[@"img"];
    NSString *steps = imageDict[@"step"];
    
    self.foodImageView.frame = CGRectMake(5, 5, kScreenSize.width - 10, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:190]);
    //取消 选中 效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];;
    CGRect labelFrame = self.foodLabel.frame;
    CGFloat h = [LZXHelper textHeightFromTextString:steps width:kScreenSize.width - 20 fontSize:16];
    labelFrame.origin.y = CGRectGetMaxY(self.foodImageView.frame)+10;
    labelFrame.size.height = h;
    self.foodLabel.frame = labelFrame;
    self.foodLabel.text = steps;
    //NSLog(@"%@",self.foodLabel.text);
}
- (void)showDataWithModel:(LittleLifeModel *)model{
    self.model = model;
    self.foodImageView.frame = CGRectMake(5, 5, kScreenSize.width - 10, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:190]);
    //取消 选中 效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    CGRect labelFrame = self.foodLabel.frame;
    CGFloat h = [LZXHelper textHeightFromTextString:self.model.title width:kScreenSize.width - 20 fontSize:16];
    labelFrame.origin.y = CGRectGetMaxY(self.foodImageView.frame)+10;
    labelFrame.size.height = h;
    self.foodLabel.frame = labelFrame;

    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:self.model.faceimg] placeholderImage:[UIImage imageNamed:@"littleLift"]];
    self.foodLabel.text = self.model.title;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
