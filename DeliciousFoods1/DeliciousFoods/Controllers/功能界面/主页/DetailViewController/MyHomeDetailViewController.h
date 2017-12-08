//
//  MyHomeDetailViewController.h
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/26.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "GSViewController.h"

@interface MyHomeDetailViewController : GSViewController

@property (nonatomic,copy) NSString *homeUrl;

@property (nonatomic,copy) NSString *comment;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userImageUrl;
@property (nonatomic,copy) NSString *adress;
@property (nonatomic,copy) NSString *pictureUrl;

@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *thereLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;




@property (nonatomic,strong) NSMutableArray *dataArr;
//下载管理
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
//记录当前页
@property (nonatomic,assign) NSInteger currentPage;
//是否刷新 加载更多
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadMore;


@end
