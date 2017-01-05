//
//  UIButton+OKExtension.h
//  SendHttpDemo
//
//  Created by mao wangxin on 2016/12/28.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OKButtonEdgeInsetsStyle) {
    OKButtonEdgeInsetsStyleTop, // image在上，label在下
    OKButtonEdgeInsetsStyleLeft, // image在左，label在右
    OKButtonEdgeInsetsStyleBottom, // image在下，label在上
    OKButtonEdgeInsetsStyleRight // image在右，label在左
};

typedef void (^TouchedBlock)(UIButton *btn);


@interface UIButton (OKExtension)

/**
 按钮开始倒计时
 
 @param time     倒计时时间
 @param norTitle 普通状态时标题
 @param selTitle 高亮状态时标题
 @param norColor 普通状态时标题颜色
 @param selColor 高亮状态时标题颜色
 @param blcok    倒计时完成Block回调
 */
- (dispatch_source_t)startWithTime:(NSInteger)time
                    btnNormalTitle:(NSString *)norTitle
                     selectedTitle:(NSString *)selTitle
                       normalColor:(UIColor *)norColor
                     selectedColor:(UIColor *)selColor
                     completeBlock:(void(^)())blcok;


/**
 统一带园角的宽大按钮样式

 @param supview   父视图
 @param rect      在父位置
 @param title     标题
 @param img       图片
 @param blk       点击回调
 @return          返回该按钮
 */
+ (instancetype)bigBtnToView:(UIView *)supview
                       frame:(CGRect)rect
                       title:(NSString *)title
                       image:(UIImage *)img
                  clickBlock:(void (^)(UIButton *button))blk;

/**
 按钮点击以Block方式回调

 @param handler 点击事件的回调
 */
-(void)addTouchUpInsideHandler:(TouchedBlock)handler;


/**
 button不同状态的背景颜色（代替图片）

 @param backgroundColor 图片代替背景色
 @param state 状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
                  forState:(UIControlState)state;

/**
 *  设置属性文字
 *
 *  @param textArr   需要显示的文字数组,如果有换行请在文字中添加 "\n"换行符
 *  @param fontArr   字体数组, 如果fontArr与textArr个数不相同则获取字体数组中最后一个字体
 *  @param colorArr  颜色数组, 如果colorArr与textArr个数不相同则获取字体数组中最后一个颜色
 *  @param spacing   换行的行间距
 *  @param alignment 换行的文字对齐方式
 */
- (void)setAttriStrWithTextArray:(NSArray *)textArr
                         fontArr:(NSArray *)fontArr
                        colorArr:(NSArray *)colorArr
                     lineSpacing:(CGFloat)spacing
                       alignment:(NSTextAlignment)alignment;


/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style 标题和图片的布局样式
 *  @param space 标题和图片的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(OKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
