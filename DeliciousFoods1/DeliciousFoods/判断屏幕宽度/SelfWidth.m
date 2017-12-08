//
//  SelfWidth.m
//  DeliciousFoods
//
//  Created by qianfeng01 on 15/10/21.
//  Copyright (c) 2015年 小山. All rights reserved.
//

#import "SelfWidth.h"

@implementation SelfWidth

+ (CGFloat)testSelfWidth:(CGFloat)width heigh:(CGFloat)height WithHigh:(CGFloat)h{
    
    if (width == 320) {
        if ( height == 480) {
            return h*0.8;
        }else{
            return h*0.9;
        }
    }
    if (width == 375) {
        return h;
    }else{
        return h*1.2;
    }
    
}

@end
