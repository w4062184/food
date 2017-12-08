//
//  MenusTableViewCell.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong,nonatomic) NSArray *arr;
- (void)showDataWithArr:(NSArray *)arr;

@end
