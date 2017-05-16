//
//  OKFrameDefiner.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#ifndef OKFrameDefiner_h
#define OKFrameDefiner_h

//----------------------公共尺寸类宏---------------------------

//系统UIableBar高度
#define kTabbarHeight            49

//所有表格顶部空出10的间隙
#define kTableViewTopSpace       10

//所有控件离屏幕边缘间距,(上下左右)
#define KViewLineSpacing         15

//默认cell高度
#define kDefaultCellHeight       44

//默认控件圆角度
#define kDefaultCornerRadius     5

//系统导航高度(没有包含电池栏)
#define kNavigationBarHeight     44

/** 图片压缩率*/
#define OKMaxPixelSize           (1/[UIScreen mainScreen].scale)

//获取屏幕宽度
#define Screen_Width             ([UIScreen  mainScreen].bounds.size.width)

//获取屏幕高度
#define Screen_Height            ([UIScreen mainScreen].bounds.size.height)

//状态栏高度 (电池栏)
#define kStatusBarHeight         ([UIApplication sharedApplication].statusBarFrame.size.height)

// 除了状态栏的高度
#define kExceptStatusBarHeight   (Screen_Width - kStatusBarHeight)

/**< 导航栏和状态栏的高度*/
#define kStatusBarAndNavigationBarHeight  (kNavigationBarHeight + kStatusBarHeight)


/** 全局分割线高度*/
#define OKLineHeight            (0.5)

/** 全局表组与组之间的间隔*/
#define OKGroupLineHeight       (10)

#endif /* OKFrameDefiner_h */
