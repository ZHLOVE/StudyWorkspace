//
//  CCTabBar.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/17.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKAppTabBar : UITabBar

/** 重复点击tabBar回调 */
@property (nonatomic, copy) void (^repeatTouchDownItemBlock)(UITabBarItem *item);

/**
 * 更换TabBar图片
 */
- (void)setTabBarItemImages:(NSArray *)imageArr;

@end
