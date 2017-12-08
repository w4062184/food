//
//  WaterLayout.h
//  瀑布流
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 刘强强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterLayout;

@protocol WaterLayoutDelegate <NSObject>

-(CGFloat)waterLayout:(WaterLayout *)waterLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterLayout : UICollectionViewLayout
/**
 *  屏幕边缘间距
 */
@property(nonatomic,assign)UIEdgeInsets edgeInsets;
/**
 *  每一列的间距
 */
@property(nonatomic,assign)CGFloat colMargin;
/**
 *  每一行的间距
 */
@property(nonatomic,assign)CGFloat rowMargin;
/**
 *  有多少列
 */
@property(nonatomic,assign)NSInteger colCount;

@property(nonatomic,weak)id<WaterLayoutDelegate> delegate;


@end
