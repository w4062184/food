//
//  IngredientsViewController.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/20.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "BigViewController.h"
#import "DetailModel.h"

@interface IngredientsViewController : BigViewController

@property (nonatomic,strong) DetailModel *ingredientsModel;
@property (nonatomic,assign) float h1;
@property (nonatomic,assign) float h2;

@end
