//
//  WaterLayout.m
//  瀑布流
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 刘强强. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout ()

/**
 *  每一列最大的Y值数据
 */
@property(nonatomic,strong) NSMutableDictionary *colMaxYDic;
/**
    每一列的所有attrs属性
 */
@property(nonatomic,strong) NSMutableArray *attrsArr;

@end


@implementation WaterLayout

-(NSMutableDictionary *)colMaxYDic {
    if (_colMaxYDic == nil) {
        
        self.colMaxYDic = [[NSMutableDictionary alloc] init];
        
    }
    return _colMaxYDic;
}

-(NSMutableArray *)attrsArr {
    if (_attrsArr == nil) {
        
        self.attrsArr = [[NSMutableArray alloc] init];
        
    }
    return _attrsArr;
}

-(instancetype)init {
    if (self = [super init]) {
        
        self.colMargin = 5;
        self.rowMargin = 5;
        self.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.colCount = 2;

    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
/**
 *  每次布局之前的准备
 */
-(void)prepareLayout {
    
    [super prepareLayout];
    
    for (int i = 0; i < self.colCount; i ++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.colMaxYDic[column] = @(self.edgeInsets.top);
        
    }
    
    [self.attrsArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i ++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArr addObject:attrs];
    }
}

/**
 *  返回所有item的尺寸
 */
-(CGSize)collectionViewContentSize {
    //假设最大的为第0列
    __block NSString  *maxColY = @"0";
    
    //遍历字典找出最短的那一列
    [self.colMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString *colNum , NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.colMaxYDic[maxColY] floatValue]) {
            maxColY = colNum;
            
        }
    }];

    return CGSizeMake(0, [self.colMaxYDic[maxColY] floatValue] + self.edgeInsets.bottom);
}

/**
 *  返回indexpath对应的item的属性
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //假设最短的为第0列
    __block NSString  *minColY = @"0";
    
    //遍历字典找出最短的那一列
    [self.colMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString *colNum , NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.colMaxYDic[minColY] floatValue]) {
            minColY = colNum;
            
        }
    }];
    
    /**
     *  计算每一列宽度
     */
    CGFloat colW = (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.colMargin * (self.colCount - 1)) / self.colCount;
    /**
     *  计算每一列宽度
     */
    CGFloat colH = [self.delegate waterLayout:self heightForWidth:colW atIndexPath:indexPath];
    /**
     *  计算每一列X
     */
    CGFloat colX = self.edgeInsets.left + (self.colMargin + colW ) * [minColY intValue];
    /**
     *  计算每列的Y
     */
    CGFloat colY = self.rowMargin + [self.colMaxYDic[minColY] floatValue];
    
    /**
     *  最新最大Y值
     */
    self.colMaxYDic[minColY] = @(colY + colH);

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.frame = CGRectMake(colX, colY, colW, colH);
    
    return attrs;
    
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrsArr;
    
}

@end
