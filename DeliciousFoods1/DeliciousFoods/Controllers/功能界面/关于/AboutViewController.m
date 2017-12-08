//
//  AboutViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "AboutViewController.h"
#import "SDImageCache.h"
#import "LoveViewController.h"

@interface AboutViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self createTableView];
    self.title = @"关于作者";
    // Do any additional setup after loading the view.
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height  - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
}

- (void)dataInit{
    _dataArr = [[NSMutableArray alloc] init];
    //NSArray *arr1 = @[@"推送设置",@"开启推送通知",@"开启关注通知"];
    //[_dataArr addObject:arr1];
    
    NSArray *arr2 = @[@"名称:芳之味",@"开发者:SBS",@"联系方式:184229441@qq.com"];
    [_dataArr addObject:arr2];
    
    [_tableView reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    //取消 选中 效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"关于作者";
}

- (void)swClick:(UISwitch *)sw{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

 */

@end
