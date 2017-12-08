//
//  HomeModel.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel



@property (nonatomic, assign) NSInteger weekly_id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *serial_number;

@property (nonatomic, assign) NSInteger cover_picture_id;

@property (nonatomic, assign) NSInteger foodzine_id;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *edit_time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *foodzine_name;

@property (nonatomic, assign) NSInteger weekly_state;

@property (nonatomic, copy) NSString *picture_url;

@property (nonatomic, copy) NSString *online_time;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *user_image;






@property (nonatomic, copy) NSString *summary;

@property (nonatomic, assign) long long modifiedTime;

@property (nonatomic, copy) NSString *articleId;

@property (nonatomic, assign) NSInteger renderType;

@property (nonatomic, copy) NSString *weblink;

@property (nonatomic, assign) long long createdTime;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *largeIcon;

@property (nonatomic, assign) NSInteger categoryGroupId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *englishName;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;


@end
