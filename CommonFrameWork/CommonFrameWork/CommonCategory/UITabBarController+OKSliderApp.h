//
//  UITabBarController+OKSliderApp.h
//  CommonFrameWork
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//  一个方法初始化左侧侧滑视图

#import <UIKit/UIKit.h>

@interface UITabBarController (OKSliderApp)

/**
 * 初始化左侧侧滑视图
 * 警告：此方法一定要在UITabBarController的 viewDidAppear方法中调用
 
例如eg: 在UITabBarController的viewDidAppear方法中加入下面的代码即可
- (void)initAppSliderVC
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"初始化:此Block只需走一次");
        SEL selector = NSSelectorFromString(@"initAppSliderVCWithName:");
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:@"需要侧滑的控制器名称"];
        }
    });
}
 */
- (BOOL)initAppSliderVCWithName:(NSString *)vcName;

/**
 是否关闭侧滑视图

 @param openFlag @1：打开，@0关闭
 */
- (void)showAppSliderView:(NSNumber *)openFlag;

@end
