//
//  OkdeerHUD.h
//  Example
//
//  Created by mao wangxin on 2017/9/7.
//  Copyright © 2017年 Mac. All rights reserved.
//
//  请求loadingView, 提示:此OkdeerHUD并不是单例,每次调用都会创建一个新的View, 以防止多个页面调用隐藏时会移除其他页面的HUD

#import <UIKit/UIKit.h>

@interface OkdeerHUD : UIView

/**
 在window上显示HUD (不会自动消失)
 */
void showLoadingToWindow();

/**
 在window上显示HUD (不会自动消失)

 @param text 提示语
 */
void showLoadingToWindowWithText(NSString *text);

/**
 在指定addView上显示HUD (不会自动消失)

 @param addView HUD的父视图
 */
void showLoadingToView(UIView *addView);

/**
 在指定addView上显示HUD (不会自动消失)

 @param addView HUD的父视图
 @param text 提示语
 */
void showLoadingToViewWithText(UIView *addView, NSString *text);

/**
  在window上显示带图片的HUD

 @param image 需要显示的图片
 */
void showToastImageToWindow(UIImage *image, NSTimeInterval duration, void(^hideBlock)());

/**
 隐藏window上创建的HUD
 */
bool hideLoadingFromWindow();

/**
 延迟隐藏Window上的HUD

 @param duration 秒
 @param hideBlock 回调
 */
void hideWindowLoadingDelay(NSTimeInterval duration, void(^hideBlock)());

/**
 隐藏指定view上创建的HUD

 @param view HUD的父视图
 */
bool hideLoadingFromView(UIView *view);

/**
 延迟隐藏UIView上的HUD
 
 @param duration 秒
 @param hideBlock 回调
 */
void hideViewLoadingDelay(UIView *view, NSTimeInterval duration, void(^hideBlock)());

@end
