//
//  CCTabBar.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/17.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKAppTabBar.h"
#import "OKTabBarInfoModel.h"

@implementation OKAppTabBar

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
    if (self.items.count>button.tag) {
        if (self.repeatTouchDownItemBlock) {
            UITabBarItem *touchItem = self.items[button.tag];
            self.repeatTouchDownItemBlock(touchItem);
        }
    }
}

#pragma mark - 设置tabbar图片

/**
 * 更换TabBar图片
 */
- (void)setTabBarItemImages:(NSArray *)imageArr
{
    if (imageArr.count < self.items.count) return;
    
    for (int i=0; i<imageArr.count; i++) {
        OKTabBarInfoModel *infoModel = imageArr[i];
        if (![infoModel isKindOfClass:[OKTabBarInfoModel class]]) continue;
        
        UITabBarItem *item = self.items[i];
        
        //背景图片
        UIImage *bgImage = infoModel.tabBarBgImage;
        if ([bgImage isKindOfClass:[UIImage class]]) {
            self.backgroundImage = [bgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        //Item标题
        NSString *itemTitle = infoModel.tabBarItemTitle;
        if ([itemTitle isKindOfClass:[NSString class]]) {
            item.title = itemTitle;
        }
        
        //普通状态图片
        UIImage *normolImage = infoModel.tabBarNormolImage;
        if ([normolImage isKindOfClass:[UIImage class]]) {
            item.image = [normolImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        //选中状态图片
        UIImage *selectedImage = infoModel.tabBarSelectedImage;
        if ([selectedImage isKindOfClass:[UIImage class]]) {
            item.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        //普通状态标题文字颜色
        UIColor *normolTitleColor = infoModel.tabBarNormolTitleColor;
        if ([normolTitleColor isKindOfClass:[UIColor class]]) {
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName:normolTitleColor} forState:UIControlStateNormal];
        }
        
        //选中状态标题文字颜色
        UIColor *selectedTitleColor = infoModel.tabBarSelectedTitleColor;
        if ([selectedTitleColor isKindOfClass:[UIColor class]]) {
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName:selectedTitleColor} forState:UIControlStateSelected];
        }
        
        /** 设置标题和图片偏移量 */
        item.titlePositionAdjustment = UIOffsetMake(0, infoModel.tabBarTitleOffset);
        item.imageInsets = UIEdgeInsetsMake(infoModel.tabBarImageOffset, 0, -infoModel.tabBarImageOffset, 0);
    }
}

@end
