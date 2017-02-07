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
- (void)addLeftBarButtonItem:(UIImage *)normolImage
                   highImage:(UIImage *)highImage
                      target:(id)target
                    selector:(SEL)selector;

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(UIImage *)normolImage
                    highImage:(UIImage *)highImage
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

/**
 *  返回到指定控制器
 */
- (BOOL)shouldPopToCustomVC:(NSString *)classStr;

/**
 *  进入到指定控制器
 */
- (void)pushToCustomVC:(NSString *)classStr title:(NSString *)title;

/**
 *  此导航条仅供上一个页面没有导航栏, 下一个页面手势滑动边缘返回时会顶部异常的情况,
 *  在导航底部添加一个假的导航view
 */
- (void)showFakeNavBarWhenScreenEdgePanBack;

/**
 *  获取最顶层的控制器
 */
+ (UIViewController *)currentTopViewController;

@end
