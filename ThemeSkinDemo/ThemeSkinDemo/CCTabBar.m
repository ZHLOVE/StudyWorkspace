//
//  CCTabBar.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/17.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CCTabBar.h"
#import "UIView+OKTool.h"
#import "UIImage+OKExtension.h"
#import "CCConst.h"

// rgb颜色转换（16进制->10进制）
#define UIColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation CCTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]]) continue;
        button.tag = index;
        
        // 增加索引
        index++;
        
        //添加双击事件
        [button addTarget:self action:@selector(repeatClickButton:) forControlEvents:UIControlEventTouchDownRepeat];
    }
}

#pragma mark - 添加tabbar双击事件

/**
 * 双击tabbar按钮事件
 */
- (void)repeatClickButton:(UIControl *)button
{
    UITabBarItem *touchItem = (self.items.count>button.tag) ? self.items[button.tag] : nil;
    
    UIViewController *tabBarVC = self.superViewController;
    if (tabBarVC && [tabBarVC isKindOfClass:[NSClassFromString(@"CCTabBarViewController") class]]) {
        //忽略警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([tabBarVC respondsToSelector:@selector(didRepeatTouchDownTabBarItem:)]) {
            [tabBarVC performSelector:@selector(didRepeatTouchDownTabBarItem:) withObject:touchItem];
        }
#pragma clang diagnostic pop
    }
}

#pragma mark - 设置tabbar图片

/**
 * 更换TabBar图片
 */
- (void)setTabBarItemImages:(NSArray *)imageArr
{
    if (imageArr.count != self.items.count) return;
    NSInteger index = 0;
    
    for (UITabBarItem *item in self.items) {
        NSDictionary *tabBarInfoDic = imageArr[index];
        
        //设置背景图片
        UIImage *bgImage = tabBarInfoDic[CCTabBarBgImageKey];
        if ([bgImage isKindOfClass:[UIImage class]]) {
            self.backgroundImage = [bgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        //设置普通状态图片
        UIImage *normolImage = tabBarInfoDic[CCTabBarNormolImageKey];
        if ([normolImage isKindOfClass:[UIImage class]]) {
            item.image = [normolImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        //设置选中状态图片
        UIImage *selectedImage = tabBarInfoDic[CCTabBarSelectedImageKey];
        if ([selectedImage isKindOfClass:[UIImage class]]) {
            item.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        item.titlePositionAdjustment = UIOffsetMake(0, -10);
        item.imageInsets = UIEdgeInsetsMake(-20, 0, 20, 0);
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x282828), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0xfe9b00), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        index++;
    }
}

@end
