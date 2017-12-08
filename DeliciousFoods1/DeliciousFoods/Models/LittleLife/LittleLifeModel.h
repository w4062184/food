//
//  LittleLifeModel.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/22.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "BaseModel.h"

@interface LittleLifeModel : BaseModel


@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger fromtype;

@property (nonatomic, assign) NSInteger look;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, copy) NSString *faceimg;

@property (nonatomic, assign) NSInteger cityid;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *tagtext;


@end
