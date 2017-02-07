//
//  UIImageView+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "UIImageView+OKExtension.h"
#import <objc/message.h>
#import "NSObject+OKRuntime.h"


static const void *UIRenderColorKey = &UIRenderColorKey;

@implementation UIImageView (OKExtension)

//增加一个渲染色的属性
- (void)setRenderColor:(UIColor *)renderColor {
    objc_setAssociatedObject(self, UIRenderColorKey, renderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = [self.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    self.tintColor = renderColor;
}

- (UIColor *)renderColor {
    return objc_getAssociatedObject(self, UIRenderColorKey);
}


+ (void)load {
    [self ok_exchangeInstanceMethod:[self class] originSelector:@selector(setImage:) otherSelector:@selector(ok_setImage:)];
}

- (void)ok_setImage:(UIImage *)image {
    if (self.renderColor) { //在先设置渲染颜色时，图片的渲染效果也存在
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    }
    [self ok_setImage:image];
}


@end
