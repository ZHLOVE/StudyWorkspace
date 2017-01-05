//
//  UITextField+OKExtension.h
//  基础框架类
//
//  Created by 雷祥 on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//注：替换了setPlaceholder:方法，使得在设置了attributedPlaceholder属性的情况下，再次设置placeholder会保留attributedPlaceholder中的属性
@interface UITextField (OKExtension)
/**
 *  设置提示语的字体属性
 */
- (void)setupPlaceholder:(NSString *)placeholder attribute:(NSDictionary *)attributes;

/**
 *  得到选中的范围
 *
 *  @return  NSRange
 */
- (NSRange)selectedRange;

/**
 *  设置选中的范围
 *
 *  @param range    range
 */
- (void)setSelectedRange:(NSRange)range;

@end
