//
//  OKPickerView.h
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKPickerView : UIView

/**
 选择器

 @param title 标题
 @param pickDataArr 选择器每一行内容(支持NSAttributedString, NSString)
 @param sureBlock 确定block
 @param cancelBlock 取消block
 @return  选择器实例
 */
+ (instancetype)showPickerViewWithTitle:(id)title
                            pickDataArr:(NSArray *)pickDataArr
                              sureBlock:(void(^)(NSInteger rowIndex))sureBlock
                            cancelBlock:(void (^)())cancelBlock;

@end
