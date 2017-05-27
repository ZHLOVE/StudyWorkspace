//
//  LukeView.m
//  DrawDemo
//
//  Created by mao wangxin on 2017/5/25.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "LukeView.h"

@implementation LukeView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 10, 10);
    
    CGContextAddLineToPoint(ctx, 100, 100);
    
    CGContextStrokePath(ctx);
}

@end
