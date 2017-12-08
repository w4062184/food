  //
//  SearchViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResoutModel.h"
#import "SearchResoutCell.h"
#import "DetailViewController.h"

@interface SearchViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISearchBar *searchBar;

//表格视图和数据源
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewDataArr;

//下载管理
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
//显示条数
@property (nonatomic,assign) NSInteger num;
//显示页数
@property (nonatomic,assign) NSInteger startPage;

//是否刷新 加载更多
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadMore;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    self.tabBarController.tabBar.hidden = NO;
    
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:0.52 green:0.41 blue:0.8 alpha:1];
    self.title = @"搜索";
    [self createAF];
    
    [self createTableView];
    [self createSearchItem];
    self.startPage = 0;
    self.num = 20;
    [self createPullUpView];
    //[self createRefreshView];
    if (self.searchKeyword.length) {
        NSString *url = [NSString stringWithFormat:kMenu,self.searchKeyword,self.num,self.startPage];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self addTaskWithUrl:url];

    }

    
    // Do any additional setup after loading the view.
}

- (void)createAF{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

- (void)createSearchItem{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    self.searchBar.placeholder = @"菜谱、食材搜索";
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    //[self.view addSubview:self.searchBar];
    
    self.tableViewDataArr = [[NSMutableArray alloc] init];
}

#pragma mark - 实现searchBar协议方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //显示cancel 按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    //将要结束编辑时
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //点击cancel 按钮
    searchBar.text = @"";
    [searchBar resignFirstResponder];   //辞去第一响应者
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //点击search
    [searchBar resignFirstResponder];
    self.startPage = 0;
    self.num = 20;
    NSString *url = [NSString stringWithFormat:kMenu,self.searchBar.text,self.num,self.startPage];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",url);
    [self addTaskWithUrl:url];
    //NSLog(@"%@",url);
}

- (void)createRefreshView{
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.startPage = 0;
        NSString *url = [NSString stringWithFormat:kMenu,weakSelf.searchBar.text,weakSelf.num,weakSelf.startPage];
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
        if (weakSelf.searchBar.text.length) {
            weakSelf.isLoadMore = YES;
            weakSelf.startPage += 20;
            NSString *url = [NSString stringWithFormat:kMenu,weakSelf.searchBar.text,weakSelf.num,weakSelf.startPage];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [weakSelf addTaskWithUrl:url];
        
        }else{
            
            weakSelf.isLoadMore = YES;
            weakSelf.startPage += 20;
            NSString *url = [NSString stringWithFormat:kMenu,weakSelf.searchKeyword,weakSelf.num,weakSelf.startPage];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",url);

            [weakSelf addTaskWithUrl:url];

        }
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
            
            if (weakSelf.startPage == 0) {
                [weakSelf.tableViewDataArr removeAllObjects];
            }
            
            NSDictionary *baseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dict = baseDict[@"result"];
            NSArray *resultArr = dict[@"data"];
            
            if (resultArr.count == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"小贴士提醒" message:@"搜索无结果" delegate:self cancelButtonTitle:@"了解" otherButtonTitles:@"关闭", nil];
                [alert show];
                [weakSelf.tableView reloadData];
                [weakSelf endRefreshing];
                
            }
            
            for (NSDictionary *resultDict in resultArr) {
                SearchResoutModel *model = [[SearchResoutModel alloc] init];
                [model setValuesForKeysWithDictionary:resultDict];
                model.stepsArr = resultDict[@"steps"];
                [weakSelf.tableViewDataArr addObject:model];
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

- (void)createTableView{
    //半透明条(导航条/tabBar) 对滚动视图的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //如果 autolayout 自动计算cell 高需要设置预设高
    self.tableView.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64);

    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResoutCell" bundle:nil] forCellReuseIdentifier:@"SearchResoutCell"];
    [self.view addSubview:self.tableView];

}
#pragma mark - TableView协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResoutCell" forIndexPath:indexPath];
    SearchResoutModel *model = self.tableViewDataArr[indexPath.row];
    //填充
    [cell setSearchResoutModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelfWidth testSelfWidth:kScreenSize.width heigh:kScreenSize.height WithHigh:130];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.model = self.tableViewDataArr[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
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
