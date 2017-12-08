//
//  MyHomeViewController.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "GSViewController.h"

@interface MyHomeViewController : GSViewController <UICollectionViewDelegate,UICollectionViewDataSource>
//数据源
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;
//下载管理
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
//记录当前页
@property (nonatomic,assign) NSInteger currentPage;
//是否刷新 加载更多
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,copy) NSString *passUrl;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *name;
//- (void)leftClick:(UIButton *)button;
//- (void)roghtClick:(UIButton *)button;
- (void)createCollectionView;
- (void)createRefreshView ;
- (void)createPullUpView;
- (void)endRefreshing;
- (void)addTaskWithUrl:(NSString *)url;


@end
