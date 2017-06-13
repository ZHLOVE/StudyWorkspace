//
//  UIImageView+OKCornerRadius.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (OKCornerRadius)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)ok_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)ok_cornerRadiusRoundingRect;

- (void)ok_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
