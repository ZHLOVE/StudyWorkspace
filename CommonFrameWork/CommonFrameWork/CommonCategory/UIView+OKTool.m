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
-(instancetype)addLineToPosition:(OKDrawLinePosition)position
                       lineWidth:(CGFloat)lineWidth
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
            line.frame = CGRectMake(self.frame.size.width-lineWidth, 0, lineWidth, self.frame.size.height);
        }
            break;
        default:
            break;
    }
    line.backgroundColor = Color_Line;
    [self addSubview:line];
    return line;
}

/**
 * 设置圆角，边框宽度和颜色
 */
- (void)ok_setCornerRadius:(CGFloat)radius
               borderColor:(UIColor *)color
               borderWidth:(CGFloat)borderWidth
{
    if (radius >= 0) {
        [self.layer setCornerRadius:radius];
    }
    self.layer.borderColor = color ? color.CGColor : [UIColor clearColor].CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

/**
 * 设置圆角
 */
- (void)ok_setCornerRadius:(CGFloat)radius {
    [self ok_setCornerRadius:radius borderColor:nil borderWidth:0];
}

/**
 *  判断self和view是否重叠
 */
- (BOOL)intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
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

/**
 *  快速根据xib创建View
 */
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].firstObject;
}

@end

@implementation UITableView (XibTool)

/**
 * 注册Xib Cell
 */
- (void)registerXib:(Class)className cellId:(NSString *)identifier
{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(className)
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}

@end
