//
//  MGSManager.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/23.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
#import "FMDatabase.h"

@interface MGSManager : NSObject

//单例
+ (MGSManager *)sharedManager;
@property (nonatomic,strong) DetailModel *model;

- (void)insertModel:(id)model ;
//删除指定的应用数据 根据指定的类型
- (void)deleteModelForAppId:(NSString *)appId ;

//根据记录类型 查找 指定的记录
- (NSArray *)readModelsWithRecordType;

//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistAppForAppId:(NSString *)appId ;
//根据 指定的记录类型  返回 记录的条数
//- (NSInteger)getCountsFromAppWithRecordType:(NSString *)type;


@end
