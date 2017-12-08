//
//  ShowTableViewCell.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/26.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface ShowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fooodImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (strong,nonatomic) HomeModel *model;
- (void)showDataWithModel:(HomeModel *)model;



@end
