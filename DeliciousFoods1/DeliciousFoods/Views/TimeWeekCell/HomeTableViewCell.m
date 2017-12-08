//
//  HomeTableViewCell.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "HomeTableViewCell.h"


@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 @property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
 @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
 @property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *userImage;
 @property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

 */

- (void)showDataWithModel:(HomeModel *)model{
    self.model = model;
    //取消 选中 效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:model.picture_url] placeholderImage:[UIImage imageNamed:@"homePlaceHoder"]];
    self.titleLabel.text = [NSString stringWithFormat:@"刊号:%@",model.serial_number];
    
    self.foodNameLabel.text = model.foodzine_name;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:model.user_image] placeholderImage:[UIImage imageNamed:@"homeUserImage"]];
    self.userNameLabel.text = model.user_name;
    
    CGRect labelFrame = self.foodNameLabel.frame;
    CGFloat h = [LZXHelper textHeightFromTextString:self.model.title width:kScreenSize.width - 175 fontSize:17];
    labelFrame.size.height = h;
    self.foodNameLabel.frame = labelFrame;
    
    CGRect userImageFrame = self.userImage.frame;
    userImageFrame.origin.y = CGRectGetMaxY(self.foodNameLabel.frame)+5;
    self.userImage.frame = userImageFrame;
    self.userNameLabel.frame = CGRectMake(195, CGRectGetMaxY(self.foodNameLabel.frame)+5, kScreenSize.width - 180, 20);
    
}


@end
