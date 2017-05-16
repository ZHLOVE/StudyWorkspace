//
//  UIButton+Shortcut.h
//  ShortcutUIDemo
//
//  Created by mao wangxin on 2017/4/11.
//  Copyright © 2017年 Luke. All rights reserved.
//  利用函数式点语法来写UIButton控件

/**  eg:用法
 UIButton *button = UIButton.initWithFrame(CGRectMake(50, 100, 100, 50))
 .ok_setTitle(@"呵呵哒",0)
 .ok_setTitleColor(UIColor.green(),0)
 .ok_setBackgroundColor(UIColor.hex(@"#dedddd"),0)
 .ok_setCornerRadius(5)
 .ok_setBorderColor(UIColor.black())
 .ok_setBorderWidth(2)
 .ok_setFrame(CGRectMake(20, 100, 150, 50))
 .ok_addToView(self.view);
 
 button.touchUpInside(^(UIButton * button) {
 NSLog(@"touchUpInside---呵呵哒");
 });
 */

#import <UIKit/UIKit.h>

typedef void (^TouchBlock) (UIButton * button);


@interface UIButton (OKShortcut)


+ (UIButton * (^)(CGRect))initWithFrame;
+ (UIButton * (^)(UIButtonType))initWithType;

- (UIButton * (^)(CGRect))ok_setFrame;
- (UIButton * (^)(UIFont *))ok_setFont;
- (UIButton * (^)(NSString *,UIControlState state))ok_setTitle;

- (UIButton * (^)(UIColor *,UIControlState state))ok_setTitleColor;
- (UIButton * (^)(UIColor *,UIControlState state))ok_setTitleShadowColor;
- (UIButton * (^)(UIImage *,UIControlState state))ok_setBackgroundImage;
- (UIButton * (^)(UIColor *,UIControlState state))ok_setBackgroundColor;

- (UIButton * (^)(NSAttributedString *,UIControlState state))ok_setAttributedTitle;

- (UIButton * (^)(CGFloat))ok_setCornerRadius;
- (UIButton * (^)(CGFloat))ok_setBorderWidth;
- (UIButton * (^)(UIColor *))ok_setBorderColor;

- (UIButton * (^)(BOOL))ok_setUserInteractionEnabled;
- (UIButton * (^)(BOOL))ok_setEnabled;

- (UIButton * (^)(UIView *))ok_addToView;

- (void (^)(TouchBlock))touchUpInside;

- (void)touchUpInsideBlock:(TouchBlock)handler;

@end
