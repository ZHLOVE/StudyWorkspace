//
//  UIImageView+OKExtension.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (OKExtension)

/**< 渲染颜色替换了图片渲染颜色也在 */
@property (nonatomic, strong) UIColor *renderColor;

/**
 * 设置图片，网络图片或本地图片名
 */
- (void)ok_setImageWithString:(NSString *)image withDefaultImage:(UIImage *)defaultImage;

@end
