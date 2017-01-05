//
//  CCParkingRequestTipView.h
//  OkdeerUser
//
//  Created by mao wangxin on 2016/11/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKCommonTipView : UIView

//当前提示view在父视图上的tag
#define kRequestTipViewTag      2016

/**
 返回一个提示空白view

 @param frame 提示View大小
 @param imageName 图片名字
 @param tipText 提示文字
 @param actionTitle 按钮标题, 不要按钮可不传
 @param touchBlock 点击按钮回调Block
 @return 提示空白view
 */
+ (OKCommonTipView *)tipViewByFrame:(CGRect)frame
                       tipImageName:(NSString *)imageName
                            tipText:(id)tipText
                        actionTitle:(NSString *)actionTitle
                        actionBlock:(void(^)())touchBlock;

@end
