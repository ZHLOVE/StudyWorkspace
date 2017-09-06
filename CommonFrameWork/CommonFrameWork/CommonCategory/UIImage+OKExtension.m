//
//  UIImage+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "UIImage+OKExtension.h"
#import <Accelerate/Accelerate.h>
#import <float.h>

#define LEN_100 100 * 1000.0
#define LEN_150 150 * 1000.0
#define LEN_300 300 * 1000.0
#define LEN_500 500 * 1000.0

@implementation UIImage (OKExtension)

+ (UIImage *(^)(UIColor *))withColor {
    
    return ^(UIColor * color) {
        return [UIImage ok_imageWithColor:color];
    };
}

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

- (instancetype)circleImage
{
    // self -> 圆形图片
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片到圆上面
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)grayScale
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 width,
                                                 height,
                                                 8, // bits per component
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CFRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)scaleWithFixedWidth:(CGFloat)width
{
    float newHeight = self.size.height * (width / self.size.width);
    CGSize size = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIImage *)scaleWithFixedHeight:(CGFloat)height
{
    float newWidth = self.size.width * (height / self.size.height);
    CGSize size = CGSizeMake(newWidth, height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIColor *)averageColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (UIImage *)croppedImageAtFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x * self.scale, frame.origin.y * self.scale, frame.size.width * self.scale, frame.size.height * self.scale);
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, frame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[self scale] orientation:[self imageOrientation]];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)addImageToImage:(UIImage *)img atRect:(CGRect)cropRect{
    
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [self drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}


- (UIImage *)fillClipSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    CGContextDrawTiledImage(imageContext, (CGRect){CGPointZero, self.size}, [self CGImage]);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}


+ (UIImage *)ok_resizeImage:(NSString *)imageName viewframe:(CGRect)viewframe resizeframe:(CGRect)sizeframe
{
    UIGraphicsBeginImageContext(viewframe.size);
    [[UIImage imageNamed:imageName] drawInRect:sizeframe];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  图片处理  压缩
 */
+ (NSArray *)ok_disposeImagesWithArray:(NSArray *)imageArray
{
    NSMutableArray *fileDataMArray = [NSMutableArray array];
    
    for (UIImage *image in imageArray) {
        CGFloat quality = [self ok_compressionQuality:image];
        UIImage *newImage = nil;
        NSMutableDictionary *fileDataMDictionary = [NSMutableDictionary dictionary];
        
        if (quality < 0.4) {
            CGSize size = CGSizeMake(800, 800 * (image.size.height/image.size.width));
            newImage = [self ok_scaleToSize:image size:size];
        }
        else {
            newImage = image;
        }
        
        NSData *imageData = [self ok_compressedData:quality image:newImage];
        BOOL isJPG = NO;
        if (imageData) {
            //            CCLog(@"is jpg");
            isJPG = YES;
        } else {
            isJPG = NO;
            imageData = UIImagePNGRepresentation(image);
            //            CCLog(@"is png");
        }
        if (!imageData) {
            //            CCLog(@"error 格式不对，不是jpg或者png");
        }
        [fileDataMDictionary setObject:[NSNumber numberWithBool:isJPG] forKey:kJpgKey];
        if (imageData) {
            [fileDataMDictionary setObject:imageData forKey:kImageDataKey];
        }
        
        
        [fileDataMArray addObject:[fileDataMDictionary copy]];
    }
    return [fileDataMArray copy];
}


+ (UIImage *)ok_scaleToSize:(UIImage *)img size:(CGSize)size{
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

//压缩图片
+ (NSData *)ok_compressedData:(CGFloat)compressionQuality image:(UIImage *)image
{
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);
    return UIImageJPEGRepresentation(image, compressionQuality);
}

+ (CGFloat)ok_compressionQuality:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (!data) {
        data = UIImagePNGRepresentation(image);
    }
    
    NSUInteger dataLength = [data length];
    
    if(dataLength > LEN_100) {
        if (dataLength > LEN_500) {
            return 0.3;
        } else if (dataLength > LEN_300) {
            return  0.45;
        } else if (dataLength > LEN_150){
            return  0.65;
        } else {
            return 0.9;
        }
    } else {
        return 1.0;
    }
}

/**
 * 通过图片获取带边框的圆形图片
 */
- (UIImage *)ok_circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (![self isKindOfClass:[UIImage class]]) {
        return nil;
    }
    CGFloat borderMinWH = MIN(self.size.width, self.size.height); //取宽高的小者
    // 开启上下文,大小是图片宽高的小者加边框的两倍
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(borderMinWH + borderWidth * 2, borderMinWH + borderWidth * 2), NO, 0);
    //绘制底部的圆圈
    CGRect borderPathRect = CGRectMake(0, 0, borderMinWH + borderWidth * 2, borderMinWH + borderWidth * 2);
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithOvalInRect:borderPathRect];
    [borderColor set];
    [borderPath fill];
    
    //添加剪切的区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake( borderWidth, borderWidth, borderMinWH, borderMinWH)];
    [clipPath addClip];
    
    //绘制图片,
    CGFloat x = borderWidth - (self.size.width - borderMinWH) * 0.5;
    CGFloat y = borderWidth - (self.size.height - borderMinWH) * 0.5;
    [self drawInRect:CGRectMake(x, y, self.size.width, self.size.height)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return clipImage;
}

//给图片添加图片水印
- (UIImage *)ok_watermarkImageWithMarkImage:(UIImage *)image inRect:(CGRect)rect {
    if (![self isKindOfClass:[UIImage class]]) {
        return nil;
    }
    
    if (![image isKindOfClass:[UIImage class]]) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    [self drawAtPoint:CGPointZero];
    
    [image drawInRect:rect];
    
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return waterImage;
}


//给图片添加文字水印
- (UIImage *)ok_watermarkImageWithMarkString:(NSAttributedString *)string inRect:(CGRect)rect {
    if (![self isKindOfClass:[UIImage class]]) {
        return nil;
    }
    
    if (![string isKindOfClass:[NSAttributedString class]]) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    [self drawAtPoint:CGPointZero];
    
    [string drawInRect:rect];
    
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return waterImage;
}

/**
 * 获取data的图片类型
 */
- (NSString *)ok_typeForImageData:(NSData *)data {
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            return @"image/jpeg";
            
        case 0x89:
            return @"image/png";
            
        case 0x47:
            return @"image/gif";
            
        case 0x49:
            
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

/**
 * 截屏
 */
+ (UIImage *)ok_screenShotImageWithView:(UIView *)view size:(CGSize )size {
    if (![view isKindOfClass:[UIView class]]) {
        return nil;
    }
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = view.bounds.size;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

