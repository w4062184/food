//
//  LittleLifeCell.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/22.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LittleLifeModel.h"

@interface LittleLifeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel;


- (void)showDataWithModel:(LittleLifeModel *)model;
@property (nonatomic,strong) LittleLifeModel *model;

@end
