//
//  DetailViewController.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/19.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "GSViewController.h"
#import "DetailModel.h"

@interface DetailViewController : GSViewController

@property (nonatomic,strong) NSArray *detailArr;
@property (nonatomic,strong) DetailModel *model;
@property (nonatomic,copy) NSString *keyWord;

@end
