//
//  UIImage+OKExtension.h
//  基础框架类
//
//  Created by 雷祥 on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OKExtension)
//小方块图片
+ (UIImage *)ok_imageWithColor:(UIColor *)color;
//椭圆图片
+ (UIImage *)ok_imageOfEllipseWithColor:(UIColor *)color inFrame:(CGRect)frame;
//3倍图转2倍图
+ (UIImage *)ok_image2FromImage3:(UIImage*)image;


@end
