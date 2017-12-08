//
//  DetailCell.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/19.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LittleLifeModel.h"

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;

@property (weak, nonatomic) IBOutlet UILabel *foodLabel;

- (void)showDataWithArray:(NSDictionary *)imageDict;

- (void)showDataWithModel:(LittleLifeModel *)model;
@property (nonatomic,strong) LittleLifeModel *model;

@end
