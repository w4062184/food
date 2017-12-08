//
//  BaseViewController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:30 green:174 blue:225 alpha:1];
    [self.navigationController.navigationBar setBackgroundColor: Kcolor(246, 93, 101)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
