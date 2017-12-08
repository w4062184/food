//
//  CollctViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "CollctViewController.h"
#import "LittleLiftViewController.h"
#import "SearchViewController.h"

@interface CollctViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation CollctViewController

- (void)viewDidLoad {
    self.dataArr = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self jumpRecommendView];
    [self createDataArr];
    [self createSearchbar];
    [self createCollectionView];
    self.title = @"厨房小知识";
    // Do any additional setup after loading the view.
}

- (void)createSearchbar{
    //    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    
    self.navigationItem.rightBarButtonItem = search;
    
}

- (void)searchClick:(UIButton *)button{
    
    SearchViewController *search = [[SearchViewController alloc] init];
    
    [self.navigationController pushViewController:search animated:YES];
}


- (void)jumpRecommendView{
    NSArray *buttonName = @[@"厨房秘籍",@"减肥养生",@"美容养颜"];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kScreenSize.width/3*i, 0, kScreenSize.width/3, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35]);
        [button setBackgroundColor:[UIColor orangeColor]];
        [button setTitle:buttonName[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"Detail_btn_left"] forState:UIControlStateNormal];
        [button setBackgroundColor:Kcolor(240, 240, 240)];
        button.tag = 30+i;
        [self.view addSubview:button];

    }
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height - 64 -[SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35]);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35], kScreenSize.width , kScreenSize.height - 64 - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35]) collectionViewLayout:layout];
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //self.collectionView.bounces = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}

- (void)createDataArr{
    NSArray *liftArr = @[@"KitchenViewController",@"HealthViewController",@"BeautyViewController"];
    for (NSInteger i = 0; i < 3; i++) {
        LittleLiftViewController *little = [[NSClassFromString(liftArr[i]) alloc] init];
        little.view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64 - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35]);
        [self addChildViewController:little];
        
        [self.dataArr addObject:little.view];
    }
}

- (void)onClick:(UIButton *)button{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(button.tag - 30) inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
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
    [cell.contentView addSubview:self.dataArr[indexPath.row]];
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
