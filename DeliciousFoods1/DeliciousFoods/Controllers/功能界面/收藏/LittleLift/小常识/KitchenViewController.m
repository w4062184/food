//
//  KitchenViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/22.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "KitchenViewController.h"
#import "DetailCell.h"
#import "LittleLifeModel.h"
#import "RecommendViewController.h"

@interface KitchenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
//当前页
@property (nonatomic,assign) NSInteger currentPage;
//是否正在刷新和加载
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadMore;


@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;


@end

@implementation KitchenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    
    [self createAf];
    [self createTableView];
    [self createPullUpView];
    [self createRefreshView];
    self.currentPage = 1;
    NSString *url = [NSString stringWithFormat:kKitchen,self.currentPage,@"厨房"];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self addTaskWithUrl:url];

    // Do any additional setup after loading the view.
}

#pragma mark - 创建下载对象
- (void)createAf {
    self.manager = [AFHTTPRequestOperationManager manager];
    //设置二进制 不解析
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

//下拉刷新
-  (void)createRefreshView {
    __weak typeof(self) weakSelf = self;
    //第一个参数 刷新特效 文字特效
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //刷新的时候 回调
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;    //记录刷新效果
        weakSelf.currentPage = 1;
        //重新发送下载请求
        NSString *url = [NSString stringWithFormat:kKitchen,weakSelf.currentPage,@"厨房"];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [weakSelf addTaskWithUrl:url];
        
    }];
}

- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        //关闭刷新特效
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        //关闭上拉加载
        [self.tableView footerEndRefreshing];
    }
}

//上拉加载更多
- (void)createPullUpView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage++;
        
        //重新发送下载请求
        NSString *url = [NSString stringWithFormat:kKitchen,weakSelf.currentPage,@"厨房"];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [weakSelf addTaskWithUrl:url];
        
    }];
}

#pragma mark - 下载
- (void)addTaskWithUrl:(NSString *)url {
    __weak typeof(self) weakSelf = self;
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载完成");
        if (responseObject) {
            if (weakSelf.currentPage == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            //json  最外层是字典
            NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if (weakSelf.isLoadMore) {
                if (dictArr.count < 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲,没有更多数据了!" message:@"我们会努力寻找的" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:@"取消", nil];

                    [alert show];
                    [weakSelf endRefreshing];
                }
            }

            for (NSDictionary *connotationDict in dictArr) {
                LittleLifeModel *model = [[LittleLifeModel alloc] init];
                //kvc 赋值
                [model setValuesForKeysWithDictionary:connotationDict];
                [weakSelf.dataArr addObject:model];
            }
            //刷新表格
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshing];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络异常:%@",error);
        [weakSelf endRefreshing];
        
    }];
}




- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64  - [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:35])];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:230];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell= [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    [cell showDataWithModel:self.dataArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendViewController *recomend = [[RecommendViewController alloc] init];
    LittleLifeModel *model = self.dataArr[indexPath.row];
    recomend.url = model.url;
    [self.navigationController pushViewController:recomend animated:YES];
    
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
