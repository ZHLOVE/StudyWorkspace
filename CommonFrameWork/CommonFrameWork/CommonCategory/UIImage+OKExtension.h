//
//  UIImage+OKExtension.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageDataKey @"imageData"
#define kJpgKey @"JPG"

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

//重新设置图片大小
+ (UIImage *)ok_resizeImage:(NSString *)imageName viewframe:(CGRect)viewframe resizeframe:(CGRect)sizeframe;

//图片处理  压缩
+ (NSArray *)ok_disposeImagesWithArray:(NSArray *)imageArray;

// 按比例缩放图片
+ (UIImage *)ok_scaleToSize:(UIImage *)img size:(CGSize)size;

//压缩图片
+ (NSData *)ok_compressedData:(CGFloat)compressionQuality image:(UIImage *)image;

//压缩图片
+ (CGFloat)ok_compressionQuality:(UIImage *)image;

//获取带边框的圆形图片
- (UIImage *)ok_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//给图片添加图片水印
- (UIImage *)ok_watermarkImageWithMarkImage:(UIImage *)image inRect:(CGRect)rect;

//给图片添加文字水印
- (UIImage *)ok_watermarkImageWithMarkString:(NSAttributedString *)string inRect:(CGRect)rect;

//截屏
+ (UIImage *)ok_screenShotImageWithView:(UIView *)view size:(CGSize )size;

//获取图片数据的类型
- (NSString *)ok_typeForImageData:(NSData *)data;

@end
