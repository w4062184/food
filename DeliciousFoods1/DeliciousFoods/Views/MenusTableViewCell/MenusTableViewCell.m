//
//  MenusTableViewCell.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "MenusTableViewCell.h"

@implementation MenusTableViewCell

- (void)showDataWithArr:(NSArray *)arr{
    self.arr = arr;
    UIImage *image = [UIImage imageNamed:self.arr[2]];
    self.foodImageView.image = image;
    self.foodImageView.frame = CGRectMake(5, 5, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:230], [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:145]);
    self.nameLabel.text = [NSString stringWithFormat:@"·%@",arr[0]];
    self.detailLabel.text = arr[1];
    //取消 选中 效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
