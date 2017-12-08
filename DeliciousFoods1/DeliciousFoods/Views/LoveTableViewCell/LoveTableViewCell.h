//
//  LoveTableViewCell.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/24.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface LoveTableViewCell : UITableViewCell
@property (nonatomic,strong) DetailModel *model;

- (void)showDataWithModel:(DetailModel *)model;

- (void)showDataWithArray:(NSArray *)arr withNumber:(NSInteger)num;

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;

@property (weak, nonatomic) IBOutlet UILabel *foodName;


@end
