//
//  HomeTableViewCell.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;





@property (strong,nonatomic) HomeModel *model;
- (void)showDataWithModel:(HomeModel *)model;

@end
