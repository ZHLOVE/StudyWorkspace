//
//  UILabel+Shortcut.h
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/11.
//  Copyright © 2017年 Luke. All rights reserved.
//  利用函数式点语法来写UILabel控件

/** eg:用法
 UILabel.initWithFrame(CGRectMake(50, 300, 100, 50))
 .ok_setText(@"哈哈乐")
 .ok_setTextColor(UIColor.blue())
 .ok_setTextAlignment(NSTextAlignmentCenter)
 .ok_setShadowColor([UIColor brownColor])
 .ok_setBackgroundColor([UIColor yellowColor])
 .ok_setBorderColor(UIColor.red())
 .ok_setBorderWidth(2)
 .ok_setCornerRadius(5)
 .ok_addToView(self.view);
 */

#import <UIKit/UIKit.h>

@interface UILabel (OKShortcut)

+ (UILabel * (^)(CGRect))initWithFrame;

- (UILabel * (^)(NSString *))ok_setText;
- (UILabel * (^)(UIFont *))ok_setFont;
- (UILabel * (^)(UIColor *))ok_setTextColor;
- (UILabel * (^)(UIColor *))ok_setBackgroundColor;
- (UILabel * (^)(UIColor *))ok_setShadowColor;
- (UILabel * (^)(UIColor *))ok_setBorderColor;
- (UILabel * (^)(CGFloat))ok_setBorderWidth;
- (UILabel * (^)(CGFloat))ok_setCornerRadius;

- (UILabel * (^)(CGSize))ok_setShadowOffset;
- (UILabel * (^)(NSTextAlignment))ok_setTextAlignment;
- (UILabel * (^)(NSLineBreakMode))ok_setLineBreakMode;
- (UILabel * (^)(NSAttributedString *))ok_setAttributedText;
- (UILabel * (^)(UIColor *))ok_setHighlightedTextColor;
- (UILabel * (^)(BOOL))ok_setUserInteractionEnabled;
- (UILabel * (^)(BOOL))ok_setEnabled;
- (UILabel * (^)(NSInteger))ok_numberOfLines;

- (UILabel * (^)(UIView *))ok_addToView;


@end
