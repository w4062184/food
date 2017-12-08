//
//  DetailModel.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/19.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel


@property (nonatomic, copy) NSString *caipu_id;

@property (nonatomic, copy) NSString *burden;

@property (nonatomic, copy) NSString *imtro;

@property (nonatomic, copy) NSString *ingredients;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *albums;

@property (nonatomic, copy) NSString *passed;

@property (nonatomic, copy) NSString *user_upload;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic,strong) NSArray *stepsArr;

@end
