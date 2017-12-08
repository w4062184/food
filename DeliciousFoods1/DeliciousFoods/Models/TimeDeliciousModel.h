//
//  TimeDeliciousModel.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "BaseModel.h"

@interface TimeDeliciousModel : BaseModel

/**
 *  图片高度
 */
@property(nonatomic,assign) CGFloat h;
/**
 *  图片宽度
 */
@property(nonatomic,assign)CGFloat w;

@property (nonatomic, copy) NSString *picture_url;

@property (nonatomic, copy) NSString *food_name;

@property (nonatomic, assign) NSInteger nom_it_total;

@property (nonatomic, assign) NSInteger great_shoot_total;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, assign) NSInteger food_id;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger info_from;

@property (nonatomic, assign) NSInteger place_id;

@property (nonatomic, assign) NSInteger want_it_total;

@property (nonatomic, copy) NSString *place_name;

@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, assign) NSInteger great_find_total;

@property (nonatomic, copy) NSString *sound_comment_url;

@property (nonatomic, assign) NSInteger food_price;

@property (nonatomic, assign) NSInteger image_width;

@property (nonatomic, copy) NSString *user_image;

@property (nonatomic, assign) NSInteger user_reputation;

@property (nonatomic, assign) NSInteger uv_count;

@property (nonatomic, assign) NSInteger star;

@property (nonatomic, assign) NSInteger level_id;

@property (nonatomic, copy) NSString *publish_time;

@property (nonatomic, assign) NSInteger level_value;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger picture_id;

@property (nonatomic, copy) NSString *level_title;

@property (nonatomic, assign) CGFloat lng;

@property (nonatomic, assign) NSInteger encode_picture_id;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, assign) NSInteger image_height;

@property (nonatomic, assign) NSInteger pv_count;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, assign) NSInteger sound_comment_time;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger tweet_id;



@end
