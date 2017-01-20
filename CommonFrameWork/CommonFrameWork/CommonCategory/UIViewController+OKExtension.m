//
//  UIViewController+OKExtension.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UIViewController+OKExtension.h"
#import "UIBarButtonItem+OKExtension.h"
#import "OKColorDefiner.h"

@implementation UIViewController (OKExtension)

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(NSString *)title target:(id)target selector:(SEL)selector
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithTitle:title titleColor:Color_BlackFont target:target selector:selector];
}

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(NSString *)normolImage highImage:(NSString *)highImage target:(id)target selector:(SEL)selector
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:normolImage highImage:highImage target:target action:selector];
}

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(NSString *)normolImage highImage:(NSString *)highImage target:(id)target selector:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:normolImage highImage:highImage target:target action:selector];
}

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(NSString *)title target:(id)target selector:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:title titleColor:Color_BlackFont target:target selector:selector];
}

/**
 *  设置导航按右侧钮点击状态
 */
- (void)setRightBarItemEnable:(BOOL)enable
{
    for (UIBarButtonItem *barItem in self.navigationItem.rightBarButtonItems) {
        if (barItem.customView && [barItem.customView isKindOfClass:[UIButton class]]) {
            UIButton *rightBtn = (UIButton *)barItem.customView;
            rightBtn.enabled = enable;
            UIColor *titleColor = self.navigationController.viewControllers.count>1 ? Color_BlackFont : Color_BlackFont;
            [rightBtn setTitleColor:enable ? titleColor : [titleColor colorWithAlphaComponent:0.4]  forState:UIControlStateNormal];
        } else {
            barItem.enabled = enable;
        }
    }
}

/**
 *  返回到指定控制器
 */
- (BOOL)shouldPopToCustomVC:(NSString *)classStr
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(classStr)]) {
            [self.navigationController popToViewController:vc animated:YES];
            return YES;
        }
    }
    return NO;
}

/**
 *  进入到指定控制器
 */
- (void)pushToCustomVC:(NSString *)classStr title:(NSString *)title
{
    UIViewController *VC = [NSClassFromString(classStr) new];
    if ([VC isKindOfClass:[UIViewController class]]) {
        VC.title = title;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

@end
