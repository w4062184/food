//
//  Define.h
//  DeliciousFoods
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#ifndef DeliciousFoods_Define_h
#define DeliciousFoods_Define_h

//导入头文件
#import "LZXHelper.h"
#import "NetInterface.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "JHRefresh.h"
#import "SelfWidth.h"

//获取屏幕大小
#define kScreenSize [UIScreen mainScreen].bounds.size
//颜色
#define Kcolor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]

//调试代码
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


#endif
