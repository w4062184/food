//
//  BigViewController.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/20.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface BigViewController : UIViewController

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) DetailModel *model;

@end
