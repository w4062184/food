//
//  MyHomeViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "MyHomeViewController.h"
#import "TimeDeliciousModel.h"
#import "WaterLayout.h"
#import "TimeWeekCell.h"
#import "SearchViewController.h"
#import "MyHomeDetailViewController.h"

@interface MyHomeViewController () <WaterLayoutDelegate,UISearchBarDelegate>
@property (nonatomic,assign) CGFloat old;
@property (nonatomic,assign) BOOL isButton;
@end

@implementation MyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackImage2"]];
    imageView.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:imageView];
    
    [self createAF];
    [self createCollectionView];
    [self createRefreshView];
    [self createPullUpView];
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    self.currentPage = 1;
    self.old = 0;
    self.isButton = NO;
    self.title = self.name;
    //NSLog(@"%@",self.passUrl);
    [self addTaskWithUrl:self.passUrl];
    //[self createButton];
    // Do any additional setup after loading the view.
}

- (void)createButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = 20;
    button.frame = CGRectMake(kScreenSize.width / 4 - 40, 5, kScreenSize.width / 4, 30);
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:19];
//    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"123" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.tag = 30;
    button1.frame = CGRectMake(kScreenSize.width / 2 + 40, 5, kScreenSize.width / 4, 30);
    [button1 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    button1.titleLabel.font = [UIFont systemFontOfSize:19];
//    [button1 setBackgroundColor:[UIColor orangeColor]];

    [button1 setTitle:@"456" forState:UIControlStateNormal];
    [self.view addSubview:button1];

}

- (void)onClick:(UIButton *)button{
    self.currentPage = 1;
    switch (button.tag) {
        case 20:
            self.isButton = NO;
            [self.collectionView headerStartRefresh];
            break;
        case 30:
            self.isButton = YES;
            [self.collectionView headerStartRefresh];

            break;
    
        default:
            break;
    }
    
}


- (void)createCollectionView{
    
    WaterLayout *layout = [[WaterLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //注册集合视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeWeekCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.dataArr = [[NSMutableArray alloc] init];
}

- (void)createAF{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

- (void)createRefreshView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.currentPage = 1;
        NSString *url = [[NSString alloc] init];
        
        url = [NSString stringWithFormat:kMyHomeFood,self.number,self.currentPage];
        [weakSelf addTaskWithUrl:url];
    }];
}

- (void)createPullUpView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage ++;
        NSString *url = [[NSString alloc] init];

        url = [NSString stringWithFormat:kMyHomeFood,self.number,self.currentPage];
        [weakSelf addTaskWithUrl:url];
        
    }];

}

- (void)endRefreshing{
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.collectionView footerEndRefreshing];
    }
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultNone];
    }

}

- (void)addTaskWithUrl:(NSString *)url{
    __weak typeof(self)weakSelf = self;
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            if (weakSelf.currentPage == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *resultArr = dict[@"result"];
            if (resultArr.count == 0 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"小贴士提醒" message:@"无更多分享" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:@"关闭", nil];
                [alert show];
                [weakSelf.collectionView reloadData];
                [weakSelf endRefreshing];
            }

            for (NSDictionary *resultDict in resultArr) {
                TimeDeliciousModel *model = [[TimeDeliciousModel alloc] init];
                [model setValuesForKeysWithDictionary:resultDict];
                [weakSelf.dataArr addObject:model];
            }
            [weakSelf.collectionView reloadData];
            [weakSelf endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [weakSelf endRefreshing];
    }];
}

#pragma mark - UIcollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    TimeDeliciousModel *model = self.dataArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    [cell setTimeDeliciousModel:model];
    return cell;
    
    
}

- (CGFloat)waterLayout:(WaterLayout *)waterLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    
    TimeDeliciousModel *model = self.dataArr[indexPath.row];
    CGFloat height = model.image_height / (model.image_width * 1.0) * width;
    
    return height + 100;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
     property (nonatomic,copy) NSString *comment;
     @property (nonatomic,copy) NSString *userName;
     @property (nonatomic,copy) NSString *userImageUrl;
     @property (nonatomic,copy) NSString *adress;
     @property (nonatomic,copy) NSString *pictureUrl;
     */
    MyHomeDetailViewController *detail = [[MyHomeDetailViewController alloc] init];
    TimeDeliciousModel *model = self.dataArr[indexPath.row];
    detail.userName = model.user_name;
    detail.comment = model.comment;
    detail.userImageUrl = model.user_image;
    detail.adress = model.address;
    detail.pictureUrl = model.picture_url;
    [self.navigationController pushViewController:detail animated:YES];
    
}


#pragma mark - tabBar
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    self.navigationController.navigationBar.alpha = 0.75;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGRect rect = self.tabBarController.tabBar.frame;
//    if (self.collectionView.contentOffset.y < 0) {
//        CGRect rect = self.tabBarController.tabBar.frame;
//        rect.origin.y = self.view.bounds.size.height - 49 + 64 ;
//        self.tabBarController.tabBar.frame = rect;
//        return;
//    }
//    //NSLog(@"%f",self.tabBarController.tabBar.frame.origin.y);
////    NSLog(@"%f",self.collectionView.contentOffset.y);
//        if (self.collectionView.contentOffset.y > self.old) {
//            rect.origin.y = self.view.bounds.size.height + 64;
//            [UITabBar animateWithDuration:1 animations:^{
//                self.tabBarController.tabBar.frame = rect;
//            }];
//        }else{
//            rect.origin.y = self.view.bounds.size.height - 49 + 64 ;
//            [UITabBar animateWithDuration:0.5 animations:^{
//                self.tabBarController.tabBar.frame = rect;
//            }];
//        }
//        self.old = self.collectionView.contentOffset.y;
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGRect rect = self.tabBarController.tabBar.frame;
//    rect.origin.y = self.view.bounds.size.height - 49 + 64 ;
//    [UITabBar animateWithDuration:1 animations:^{
//        self.tabBarController.tabBar.frame = rect;
//    }];
//    //NSLog(@"sdf");
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    CGRect rect = self.tabBarController.tabBar.frame;
//    rect.origin.y = self.view.bounds.size.height - 49 + 64 ;
//    [UITabBar animateWithDuration:1 animations:^{
//        self.tabBarController.tabBar.frame = rect;
//    }];
//    //NSLog(@"15");
//}

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
