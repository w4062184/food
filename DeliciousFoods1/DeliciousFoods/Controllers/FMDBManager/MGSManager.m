//
//  MGSManager.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/23.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "MGSManager.h"

@implementation MGSManager{
    FMDatabase * _database;
    NSMutableArray *_dataArr;
}

+ (MGSManager *)sharedManager{
    static MGSManager * manager = nil;
    @synchronized(self) {
        if (manager == nil) {
            manager = [[self alloc]init ];
        }
        
    }
    return manager;
}

- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        NSString *filePath = [self getFileFullPathWithFileName:@"app.db"];
        _database = [[FMDatabase alloc] initWithPath:filePath];
        if ([_database open]) {
            NSLog(@"数据库打开成功");
            [self creatTable];
        }else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}
#pragma mark - 创建表
- (void)creatTable {
    //字段: 应用名 应用id 当前价格 最后价格 icon地址 记录类型 价格类型
    
    /**
     
     NSArray 与 NSData的相互转换 二进制
     将NSArray转化为NSData类型 ：NSData *data =[NSKeyedArchiver archivedDataWithRootObject:Array];
     将NSData转化为NSArray类型 ：NSArray *array =[NSKeyedUnarchiver unarchiveObjectWithData:data];
     
     */
    
    NSString *sql = @"create table if not exists detail(serial integer  Primary Key Autoincrement,body_html Varchar(1024),title Varchar(1024),cat_title Varchar(1024),tags Varchar(1024),imtro Varchar(1024),ingredients Varchar(1024),burden Varchar(1024),steps binary(1024))";
    //创建表 如果不存在则创建新的表
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }else{
        NSLog(@"创建表成功");
    }
}
#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory()  stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        //文件的全路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        //如果不存在可以创建一个新的
        NSLog(@"Documents不存在");
        return nil;
    }
}


//增加 数据 收藏/浏览/下载记录
//存储类型 favorites downloads browses
- (void)insertModel:(id)model {
    NSLog(@"开始添加数据");
    
    self.model = (DetailModel *)model;
    if ([self isExistAppForAppId:self.model.caipu_id]) {
        NSLog(@"this app has  recorded");
        return;
    }else{
        [_dataArr addObject: (DetailModel *)model];
    }
    
    
    NSString *sql = @"insert into detail(body_html,title,cat_title,tags,imtro,ingredients,burden,steps) values (?,?,?,?,?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sql,self.model.caipu_id,self.model.title,self.model.albums,self.model.tags,self.model.imtro,self.model.ingredients,self.model.burden,[NSKeyedArchiver archivedDataWithRootObject:self.model.stepsArr]];
    
    if (!isSuccess) {
        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
}
//删除指定的应用数据 根据指定的类型
- (void)deleteModelForAppId:(NSString *)body_html{
    NSString *sql = @"delete from detail where body_html = ? ";
    BOOL isSuccess = [_database executeUpdate:sql,body_html];
    
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}

//根据指定类型  查找所有的记录
//根据记录类型 查找 指定的记录
- (NSArray *)readModelsWithRecordType{
    
    NSString *sql = @"select * from detail";
    FMResultSet * rs = [_database executeQuery:sql];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    while ([rs next]) {
        //把查询之后结果 放在model
        //body_html,title,cat_title,tags,imtro,ingredients,burden
        DetailModel *appModel = [[DetailModel alloc] init];
        appModel.caipu_id = [rs stringForColumn:@"body_html"];
        appModel.title = [rs stringForColumn:@"title"];
        appModel.albums = [rs stringForColumn:@"cat_title"];
        appModel.tags = [rs stringForColumn:@"tags"];
        appModel.imtro = [rs stringForColumn:@"imtro"];
        appModel.ingredients = [rs stringForColumn:@"ingredients"];
        appModel.burden = [rs stringForColumn:@"burden"];
        NSData *data = [rs dataForColumn:@"steps"];
        
//        NSLog(@"data = %@",data);
//        NSLog(@"arr %@",[NSKeyedUnarchiver unarchiveObjectWithData:data]);
        
        
        //NSArray *nameArr = @[@"心灵鸡汤",@"信息测试",@"心灵探秘",@"读心技巧",@"行为剖析"];
        //    将NSArray转化为NSData类型 ：NSData *data =[NSKeyedArchiver archivedDataWithRootObject:Array];
        //    将NSData转化为NSArray类型 ：NSArray *array =[NSKeyedUnarchiver unarchiveObjectWithData:data];
        //NSData *data =[NSKeyedArchiver archivedDataWithRootObject:nameArr];
//        NSLog(@"data %@",data);

        //  将NSData转化为NSArray类型 ：NSArray *array =[NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSArray *add =[NSKeyedUnarchiver unarchiveObjectWithData:data];
        appModel.stepsArr = add;

        [arr addObject:appModel];
    }
    return arr;
}
//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistAppForAppId:(NSString *)body_html {
    NSString *sql = @"select * from detail where body_html = ? ";
    FMResultSet *rs = [_database executeQuery:sql,body_html];
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}
//根据 指定的记录类型  返回 记录的条数
- (NSInteger)getCountsFromAppWithRecordType:(NSString *)type {
    NSString *sql = @"select count(*) from detail where recordType = ?";
    FMResultSet *rs = [_database executeQuery:sql,type];
    NSInteger count = 0;
    while ([rs next]) {
        //查找 指定类型的记录条数
        count = [[rs stringForColumnIndex:0] integerValue];
    }
    return count;
}


@end
