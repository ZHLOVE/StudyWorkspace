//
//  UIViewController+OKExtension.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (OKExtension)

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(NSString *)title
                      target:(id)target
                    selector:(SEL)selector;

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(NSString *)normolImage
                   highImage:(NSString *)highImage
                      target:(id)target
                    selector:(SEL)selector;

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(NSString *)normolImage
                    highImage:(NSString *)highImage
                       target:(id)target
                     selector:(SEL)selector;
/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector;

/**
 *  设置导航右侧按钮点击状态
 */
- (void)setRightBarItemEnable:(BOOL)enable;

@end
