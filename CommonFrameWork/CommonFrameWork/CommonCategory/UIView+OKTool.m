//
//  UIView+OKTool.m
//  OkdeerUser
//
//  Created by mao wangxin on 2017/1/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UIView+OKTool.h"

#define UIColorFromHex(hexValue)        ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:1.0])
//全局灰色线条颜色
#define Color_Line                      UIColorFromHex(0xe5e5e5)

@implementation UIView (OKTool)


#pragma mark -=============== 给当前视图添加线条 ===============

/**
 给当前视图添加线条
 
 @param position 添加的位置
 @param lineWidth 天条宽度或高度
 @return 添加的线条
 */
-(instancetype)addLineToPosition:(OKDrawLinePosition)position lineWidth:(CGFloat)lineWidth
{
    UIView *line = [[UIView alloc] init];
    switch (position) {
        case OkDrawLine_top:
        {
            line.frame = CGRectMake(0, 0, self.frame.size.width, lineWidth);
        }
            break;
        case OkDrawLine_left:
        {
            line.frame = CGRectMake(0, 0, lineWidth, self.frame.size.height);
        }
            break;
        case OkDrawLine_bottom:
        {
            line.frame = CGRectMake(0, self.frame.size.height-lineWidth, self.frame.size.width, lineWidth);
        }
            break;
        case OkDrawLine_right:
        {
            line.frame = CGRectMake(0, self.frame.size.width-lineWidth, lineWidth, self.frame.size.height);
        }
            break;
        default:
            break;
    }
    line.backgroundColor = Color_Line;
    [self addSubview:line];
    return line;
}

#pragma mark -=============== 获取当前视图的控制器 ===============

/**
 获取当前视图的父视图控制器

 @return 控制器
 */
- (UIViewController *)superViewController
{
    UIResponder *rsp = self;
    while (![rsp isKindOfClass:[UIViewController class]]) {
        rsp = rsp.nextResponder;
    }
    return (UIViewController *)rsp;
}

@end
