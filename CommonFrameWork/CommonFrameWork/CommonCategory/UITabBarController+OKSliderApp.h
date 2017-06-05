//
//  UITabBarController+OKSliderApp.h
//  CommonFrameWork
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (OKSliderApp)

/**
 * 初始化左侧侧滑视图
 * 警告：此方法一定要在UITabBarController的 viewDidAppear方法中调用
 */
- (BOOL)initAppSliderVCWithName:(NSString *)vcName;

/**
 * 是否关闭侧滑视图
 */
- (void)showAppSliderView:(NSNumber *)openFlag;

@end
