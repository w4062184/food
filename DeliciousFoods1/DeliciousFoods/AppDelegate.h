//
//  AppDelegate.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;


@end
