//
//  HomeViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 小山. All rights reserved.
//
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "ShowTableViewCell.h"
#import "SearchViewController.h"
#import "MyHomeViewController.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSArray *detailArr;
//下载管理
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

//显示页数
@property (nonatomic,assign) NSInteger startPage;

//是否刷新 加载更多
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadMore;


@end

@implementation HomeViewController

- (void)createHomeDetailView{
    self.detailArr = @[@"442",@"209",@"345",@"318",@"308",@"301",@"298",@"210",@"202",@"266",@"295",@"288",@"257",@"290",@"52",@"286",@"178",@"201",@"50",@"199",@"188",@"209",@"198"];
}



- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.dataArr = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = 140;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShowTableViewCell"];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    
}

- (void)createAF{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

- (void)createRefreshView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.startPage = 1;
        NSString *url = [NSString stringWithFormat:kHomeFood,weakSelf.startPage];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [weakSelf addTaskWithUrl:url];
    }];

    
}
- (void)createPullUpView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        
        weakSelf.isLoadMore = YES;
        weakSelf.startPage ++;
        NSString *url = [NSString stringWithFormat:kHomeFood,weakSelf.startPage];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [weakSelf addTaskWithUrl:url];
    }];

}

- (void)endRefreshing{
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    
}

- (void)addTaskWithUrl:(NSString *)url{
    __weak typeof(self)weakSelf = self;
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            
            if (weakSelf.startPage == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            NSDictionary *baseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *resultArr = baseDict[@"result"];
            if (resultArr.count == 0  || weakSelf.startPage >= 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"小贴士提醒" message:@"无更多期刊" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:@"关闭", nil];
                [alert show];
                [weakSelf.tableView reloadData];
                [weakSelf endRefreshing];
            }
            for (NSDictionary *resultDict in resultArr) {
                
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:resultDict];
                [weakSelf.dataArr addObject:model];
                //NSLog(@"%@",model.imtro);
            }
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [weakSelf endRefreshing];
    }];
}
#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2) {
        ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowTableViewCell"];
        HomeModel *model = self.dataArr[indexPath.row];
        [cell showDataWithModel:model];
        return cell;

    }else{
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
        HomeModel *model = self.dataArr[indexPath.row];
        [cell showDataWithModel:model];
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyHomeViewController *myHome = [[MyHomeViewController alloc] init];
    //NSLog(@"%@",self.detailArr[indexPath.row]);
    NSInteger i = 1;
    HomeModel *model = self.dataArr[indexPath.row];
    myHome.name = model.serial_number;
    myHome.passUrl = [NSString stringWithFormat:kMyHomeFood,self.detailArr[indexPath.row],i];
    myHome.number = self.detailArr[indexPath.row];
    [self.navigationController pushViewController:myHome animated:YES];
}

#pragma mark - SearchBar
- (void)createSearchbar{
    //    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
    
    self.navigationItem.rightBarButtonItem = search;
    
}


- (void)searchClick:(UIButton *)button{
    
    SearchViewController *search = [[SearchViewController alloc] init];
    
    [self.navigationController pushViewController:search animated:YES];
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [self.tableView reloadData];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.view.backgroundColor = Kcolor(246, 93, 101);

    
    [self createAF];
    [self createHomeDetailView];
    [self createSearchbar];
    [self createTableView];
    [self createPullUpView];
    [self createRefreshView];
    self.isLoadMore = NO;
    self.isRefreshing = NO;
    self.startPage = 1;
    NSString *url = [NSString stringWithFormat:kHomeFood,self.startPage];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self addTaskWithUrl:url];

    
    // Do any additional setup after loading the view.
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
