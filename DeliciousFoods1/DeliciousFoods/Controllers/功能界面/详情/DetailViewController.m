//
//  DetailViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/19.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "DetailViewController.h"
#import "BigViewController.h"
#import "UIImageView+WebCache.h"
#import "MGSManager.h"

@interface DetailViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *viewArr;
    BOOL _isExist;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createViews];
    [self createTableView];
    self.title = @"详情";
//    UIImage *image = [[UIImage imageNamed:@"iconfont-shoucang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonClick:)];
//    self.navigationItem.rightBarButtonItem = left;
    [self createButton];
    //[SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255]
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width/4, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:220] - 20, kScreenSize.width/2, 20)];
    label.text = self.model.title;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];
//    _isExist = [[MGSManager sharedManager] isExistAppForAppId:self.model.caipu_id];
    
    
    
    
    [UICollectionView animateWithDuration:1 animations:^{
        self.tabBarController.tabBar.frame = CGRectMake(0, kScreenSize.height, kScreenSize.width, 49);
    }];
    //self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}

- (void)onBarButtonClick:(UIBarButtonItem *)button{
    if (_isExist) {
        //已经存在
        //从数据库删除
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消收藏" message:@"我们会继续努力" delegate:self cancelButtonTitle:@"取消收藏" otherButtonTitles: nil];
        UIImage *image = [[UIImage imageNamed:@"iconfont-shoucang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonClick:)];
        self.navigationItem.rightBarButtonItem = left;

        [alert show];
        [[MGSManager sharedManager] deleteModelForAppId:self.model.caipu_id];
        _isExist = NO;
        }else {
        //收藏保存到数据库
        _isExist = YES;;
        [[MGSManager sharedManager] insertModel:self.model];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:@"您可以在收藏中查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
        UIImage *image = [[UIImage imageNamed:@"iconfont-shoucangselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonClick:)];
        self.navigationItem.rightBarButtonItem = left;

        [alert show];

    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isExist = [[MGSManager sharedManager] isExistAppForAppId:self.model.caipu_id];
    if (_isExist) {
        UIImage *image = [[UIImage imageNamed:@"iconfont-shoucangselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonClick:)];
        self.navigationItem.rightBarButtonItem = left;

    }else{
        UIImage *image = [[UIImage imageNamed:@"iconfont-shoucang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonClick:)];
        self.navigationItem.rightBarButtonItem = left;

    }
    
    
}

- (void)createButton{
    
    NSArray *nameArr = @[@"相关介绍",@"材料",@"做法"];
    for (NSInteger a = 0; a < 3; a++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(a * kScreenSize.width / 3, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:220], kScreenSize.width/3, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35]);
        [button addTarget:self  action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:Kcolor(240, 240, 240)];
        [self.view addSubview:button];
        button.tag = 20 + a;
        [button setBackgroundImage:[UIImage imageNamed:@"Detail_btn_left"] forState:UIControlStateNormal];
        
        //[button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:nameArr[a] forState:UIControlStateNormal];
    }
}

- (void)onClick:(UIButton *)button{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(button.tag - 20) inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (void)createViews{
    
    viewArr = [[NSMutableArray alloc] init];
    NSArray *nameArr = @[@"AbouViewController",@"IngredientsViewController",@"PracticeViewController"];
    
    for (NSInteger a = 0; a < nameArr.count; a++) {
        BigViewController *sub = [[NSClassFromString(nameArr[a]) alloc] init];
        
        sub.model = self.model;
        sub.dataArr = self.model.stepsArr;
        
        sub.view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
        [self addChildViewController:sub];
        
        //[sub willMoveToParentViewController:self];
        [viewArr addObject:sub.view];
    }
}

- (void)createTableView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height - 64 - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255]);
    // 水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width - 0, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255])];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.albums]];
    [self.view addSubview:imageView];
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255], kScreenSize.width , kScreenSize.height - 64 - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:255]) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];

    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:viewArr[indexPath.row]];
    

    return cell;
}

////界面将要消失时
//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [UICollectionView animateWithDuration:1 animations:^{
//        self.tabBarController.tabBar.frame = CGRectMake(0, kScreenSize.height - 49, kScreenSize.width, 49);
//    }];
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
