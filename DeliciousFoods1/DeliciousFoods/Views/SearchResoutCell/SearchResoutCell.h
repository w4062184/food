//
//  SearchResoutCell.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResoutModel.h"

@interface SearchResoutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *BriefLabel;

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;





- (void)setSearchResoutModel:(SearchResoutModel *)timeModel;

@property (nonatomic,strong)SearchResoutModel *timeModel;

@end
