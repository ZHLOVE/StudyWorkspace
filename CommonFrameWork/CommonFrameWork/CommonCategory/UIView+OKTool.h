//
//  UIView+OKTool.h
//  OkdeerUser
//
//  Created by mao wangxin on 2017/1/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OkDrawLine_top,
    OkDrawLine_left,
    OkDrawLine_bottom,
    OkDrawLine_right,
} OKDrawLinePosition;

@interface UIView (OKTool)

/**
 给当前视图添加线条

 @param position 添加的位置
 @param lineWidth 天条宽度或高度
 @return 添加的线条
 */
-(instancetype)addLineToPosition:(OKDrawLinePosition)position
                       lineWidth:(CGFloat)lineWidth;

/**
 * 设置圆角，边框宽度和颜色
 */
- (void)ok_setCornerRadius:(CGFloat)radius
               borderColor:(UIColor *)color
               borderWidth:(CGFloat)borderWidth;

/**
 * 设置UI指定方向的圆角
 */
- (void)ok_setRectCorner:(UIRectCorner)rectCorner
             cornerRadii:(CGSize)cornerRadii;

/**
 * 设置圆角
 */
- (void)ok_setCornerRadius:(CGFloat)radius;

/**
 *  判断self和view是否重叠
 */
- (BOOL)intersectsWithView:(UIView *)view;

/**
 获取当前视图的父视图控制器
 
 @return 控制器
 */
- (UIViewController *)superViewController;

/**
 *  快速根据xib创建View
 */
+ (instancetype)viewFromXib;

@end

@interface UITableView (XibTool)

/**
 * 注册Xib Cell
 */
- (void)registerXib:(Class)className cellId:(NSString *)identifier;

@end
