//
//  LoveViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/22.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "LoveViewController.h"
#import "DetailViewController.h"
#import "DetailModel.h"
#import "UIButton+WebCache.h"
#import "MGSManager.h"
#import "LoveTableViewCell.h"

@interface LoveViewController () <UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isExist;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataMutableArr;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) DetailModel *model;

@end

@implementation LoveViewController

- (void)viewDidLoad {
    
//    _isExist = [[MGSManager sharedManager] isExistAppForAppId:self.model.caipu_id];

    [super viewDidLoad];
    self.title = @"收藏";
//    UIImage *image = [[UIImage imageNamed:@"iconfont-shoucangselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.rightBarButtonItem = left;

//    self.dataArr = [[MGSManager sharedManager] readModelsWithRecordType];

    self.view.backgroundColor = Kcolor(40, 50, 90);
//    self.tabBarController.tabBar.hidden = YES;
    [self createTableView];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isExist = [[MGSManager sharedManager] isExistAppForAppId:self.model.caipu_id];
    self.dataArr = [[MGSManager sharedManager] readModelsWithRecordType];
    [self.tableView reloadData];
    
    
}

- (void)onBarButtonClick:(UIBarButtonItem *)button{
    if (_isExist) {
        //已经存在
        //从数据库删除
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消收藏" message:@"我们会继续努力" delegate:self cancelButtonTitle:@"取消收藏" otherButtonTitles: nil];
        [alert show];
        [[MGSManager sharedManager] deleteModelForAppId:self.model.caipu_id];
        _isExist = NO;
    }else {
        //收藏保存到数据库
        _isExist = YES;;
        [[MGSManager sharedManager] insertModel:self.model];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:@"您可以在收藏中查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }
    
}


- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64 ) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 110;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoveTableViewCell" bundle:nil] forCellReuseIdentifier:@"LoveTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoveTableViewCell" forIndexPath:indexPath];
    
    DetailModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.model = self.dataArr[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}

//界面将要消失时
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    
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
