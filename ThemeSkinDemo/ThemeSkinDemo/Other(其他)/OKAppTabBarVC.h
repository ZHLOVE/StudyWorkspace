//
//  CCTabBarViewController.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OKTabBarInfoModel;

@interface OKAppTabBarVC : UITabBarController

/**
 * 设置默认tabBar主题图片
 */
- (void)setDefaultTabBarImages;

/**
 * 更换主题
 */
- (void)changeTabBarThemeImages:(NSArray <OKTabBarInfoModel *> *)customImageArr;

@end
