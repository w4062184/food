//
//  DeliciousFoodsTabBarController.m
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "DeliciousFoodsTabBarController.h"
#import "BaseViewController.h"

@interface DeliciousFoodsTabBarController ()

@end

@implementation DeliciousFoodsTabBarController

- (void)createNavigation{
    NSArray *nameArr = @[@"HomeViewController",@"MenusViewController",@"CollctViewController",@"AboutViewController"];
    //NSArray *imageArr = @[@"healthyEating",@"footMark",@"recommend",@"aboutOur"];
    //NSArray *imageBackArr = @[@"healthyEatingClick",@"footMarkClick",@"recommendClick",@"aboutOurClick"];
    NSArray *imagesArr = @[@"iconfont-home",@"iconfont-shuji",@"iconfont-soucang-1",@"iconfont-guanyuwomen"];
    NSArray *imagesBackArr = @[@"iconfont-nhome-1",@"iconfont-shuji-2",@"iconfont-baoxianzhushouicon25",@"iconfont-guanyuwomen-1"];
    NSArray *titleName = @[@"主页",@"菜谱",@"厨房小常识",@"关于"];
    
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    for (NSInteger a = 0; a < nameArr.count; a++) {
        Class vcClass = NSClassFromString(nameArr[a]);
        BaseViewController *base = [[vcClass alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:base];
        nav.title = titleName[a];
        
        nav.tabBarItem.image = [[UIImage imageNamed:imagesArr[a]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:imagesBackArr[a]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        [vcArr addObject:nav];
    }
    self.viewControllers = vcArr;
}

- (void)viewDidLoad {
    [self createNavigation];
    [super viewDidLoad];
    //NSLog(@"%f",kScreenSize.height);
    // Do any additional setuKp after loading the view.
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
