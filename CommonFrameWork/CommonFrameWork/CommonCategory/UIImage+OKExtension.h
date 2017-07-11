//
//  UIImage+OKExtension.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OKExtension)

+ (UIImage *(^)(UIColor *))withColor;
//小方块图片
+ (UIImage *)ok_imageWithColor:(UIColor *)color;
//椭圆图片
+ (UIImage *)ok_imageOfEllipseWithColor:(UIColor *)color inFrame:(CGRect)frame;
//3倍图转2倍图
+ (UIImage *)ok_image2FromImage3:(UIImage*)image;
//缩放图片尺寸
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (instancetype)circleImage;
// 生成一个圆形图片
+ (instancetype)circleImageNamed:(NSString *)name;

// 给定一个不要渲染的图片名称,生成一个最原始的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName;

// 灰度效果
- (UIImage *)grayScale;

// 固定宽度与固定高度
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

// 平均的颜色
- (UIColor *)averageColor;

// 裁剪图片的一部分
- (UIImage *)croppedImageAtFrame:(CGRect)frame;

// 将自身填充到指定的size
- (UIImage *)fillClipSize:(CGSize)size;

@end
