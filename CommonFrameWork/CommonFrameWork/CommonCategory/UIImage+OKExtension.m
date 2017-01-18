//
//  UIImage+OKExtension.m
//  基础框架类
//
//  Created by 雷祥 on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "UIImage+OKExtension.h"

@implementation UIImage (OKExtension)

+ (UIImage *)ok_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

//椭圆图片
+ (UIImage *)ok_imageOfEllipseWithColor:(UIColor *)color inFrame:(CGRect)frame
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, frame);

    CGContextAddEllipseInRect(context, frame);
    [color set];
    CGContextFillPath(context);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage*)ok_image2FromImage3:(UIImage*)image;
{
    if ([UIScreen mainScreen].scale == 3.0)
    {
        return image;
    }

    CGSize newSize = CGSizeMake(image.size.width*2.f/3.f, image.size.height*2.f/3.f);
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

@end
