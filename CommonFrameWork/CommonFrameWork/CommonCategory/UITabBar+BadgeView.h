//
//  UITabBar+BadgeView.h
//  TabbarDemo2
//
//  Created by Luke on 2016/12/25.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (BadgeView)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index;

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index;

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index;

@end
