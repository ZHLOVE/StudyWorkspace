//
//  UIBarButtonItem+OKExtension.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (OKExtension)


+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title
                             titleColor:(UIColor *)color
                                 target:(id)target
                               selector:(SEL)selector;


+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title
                             titleColor:(UIColor *)color
                             clickBlock:(dispatch_block_t)blk;


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                         highImage:(UIImage *)highImage
                            target:(id)target
                            action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                         highImage:(UIImage *)highImage
                        clickBlock:(dispatch_block_t)blk;

@end
