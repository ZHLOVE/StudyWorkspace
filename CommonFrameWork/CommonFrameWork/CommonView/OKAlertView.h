//
//  OKAlertView.h
//  AlertOrActionSheetDemo
//
//  Created by mao wangxin on 2017/3/28.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 单个按钮提示Alert弹框, 没有事件只做提示使用 */
#define OKAlertSingleBtnView(titleStr,messageStr,cancelTitle) [OKAlertView alertWithCallBlock:nil title:titleStr message:messageStr cancelButtonTitle:cancelTitle otherButtonTitles: nil];

typedef void(^OKAlertViewCallBackBlock)(NSInteger buttonIndex);


@interface OKAlertView : UIView

@property (nonatomic,strong) UIColor *mainColor UI_APPEARANCE_SELECTOR;

/**
 自定义的AlertView弹框
 注意:如果有设置cancelButton, 则取消按钮的buttonIndex为:0, 其他otherButton的Index依次加1;
 
 @param alertWithCallBlock     点击按钮回调Block
 @param title                  弹框标题->(支持 NSString、NSAttributedString)
 @param message                弹框描述->(支持 NSString、NSAttributedString)
 @param cancelButtonTitle      取消按钮标题->(支持 NSString、NSAttributedString)
 @param otherButtonTitles      其他按钮标题->(支持 NSString、NSAttributedString)
 */
+ (instancetype)alertWithCallBlock:(OKAlertViewCallBackBlock)alertWithCallBlock
                             title:(id)title
                           message:(id)message
                 cancelButtonTitle:(id)cancelButtonTitle
                 otherButtonTitles:(id)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;


/**
 使用方式同上个方法, (效果和上面的方法一样,c函数的方式调用代码量更少)

 @param title 弹框标题->(支持 NSString、NSAttributedString)
 @param message 弹框描述->(支持 NSString、NSAttributedString)
 @param cancelButtonTitle 取消按钮标题->(支持 NSString、NSAttributedString)
 @param otherButtonTitles 其他按钮标题->(支持 NSString、NSAttributedString)
 @param alertWithCallBlock 点击按钮回调Block
 @return 弹框实例对象
 */
OKAlertView* showAlertView(id title, id message, id cancelButtonTitle, NSArray *otherButtonTitles, OKAlertViewCallBackBlock alertWithCallBlock);


/**
 *  获取OKAlertView上的指定按钮
 *  注意:index为所有按钮数组的角标(cancelButton的角标为0 ,其他依次加1)
 */
- (UIButton *)buttonAtIndex:(NSInteger)index;


/**
 *  给OKAlertView的指定按钮设置标题
 *  注意:index为所有按钮数组的角标(cancelButton的角标为0 ,其他依次加1)
 */
- (void)setButtonTitleToIndex:(NSInteger)index title:(id)title enable:(BOOL)enable;


/**
 *  2秒自动消失的系统Alert弹框
 *
 *  @msg 提示标题->(支持 NSString、NSAttributedString)
 */
void showAlertToast(id msg);


/**
 * 2秒自动消失带标题的系统Alert弹框
 
 * @param title 提示标题->(支持 NSString、NSAttributedString)
 * @param msg   提示信息->(支持 NSString、NSAttributedString)
 */
void showAlertToastByTitle(id title, id msg);


/**
 * 指定时间消失Alert弹框

 * @param title         提示标题->(支持 NSString、NSAttributedString)
 * @param msg           提示信息->(支持 NSString、NSAttributedString)
 * @param duration      指定消失时间
 * @param dismissBlock  消失回调
 */
void showAlertToastDelay(id title, id msg, NSTimeInterval duration, void(^dismissBlock)(void));


/**
 * 显示请求的错误提示信息
 * @param error 请求错误的对象,内部会根据错误码(200-500之间)来提示
 * @param msg   提示信息->(支持 NSString、NSAttributedString)
 */
void showAlertToastByError(NSError *error, id msg);


#pragma mark - 带输入框的系统弹框

/**
 iOS8.0的带输入框的UIAlertController
 
 @param title 标题
 @param placeholder 占位文字
 @param cancelTitle 取消按钮标题
 @param otherTitle 其他按钮标题
 @param otherBlock 其他按钮回调
 @param cancelBlock 取消按钮回调
 */
+ (UIAlertController *)inputAlertWithTitle:(NSString *)title
                               placeholder:(NSString *)placeholder
                               cancelTitle:(NSString *)cancelTitle
                                otherTitle:(NSString *)otherTitle
                               buttonBlock:(void (^)(NSString *inputText))otherBlock
                               cancelBlock:(void (^)(void))cancelBlock;

@end
