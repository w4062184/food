//
//  LeftSortsViewController.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/26.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    //取消 选中 效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-shouye"];
        cell.textLabel.text = @"首页";
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-jikediancanicon"];
        cell.textLabel.text = @"菜谱";
    } else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-chufang"];
        cell.textLabel.text = @"厨房小常识";
    } else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-daohangguanyu"];
        cell.textLabel.text = @"关于作者";
    } else if (indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-shoucangselect"];
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.row == 5) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-unie62f"];
        cell.textLabel.text = @"清除缓存";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *nameArr = @[@"HomeViewController",@"MenusViewController",@"CollctViewController",@"AboutViewController",@"LoveViewController"];
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    for (NSInteger a = 0; a < nameArr.count; a++) {
        Class vcClass = NSClassFromString(nameArr[a]);
        BaseViewController *base = [[vcClass alloc] init];
        
        [vcArr addObject:base];
    }
    switch (indexPath.row) {
        case 0:
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:vcArr[0] animated:NO];
            break;
        case 1:
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:vcArr[1] animated:NO];
            break;
        case 2:
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:vcArr[2] animated:NO];
            break;
        case 3:
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:vcArr[3] animated:NO];
            break;
        case 4:
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:vcArr[4] animated:NO];
            break;
        case 5:
            [self clearCaches];
        default:
            break;
    }
}

- (void)clearCaches{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenSize.height-80, kScreenSize.width-100, 20)];
    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    label.text = [NSString stringWithFormat:@"共清除%.2fM内存",sdSize/1024.0/1024.0];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    [UIView animateWithDuration:5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
