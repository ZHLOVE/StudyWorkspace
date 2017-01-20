//
//  NSString+Extention.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (OKExtention)

/**
 * 判断是否包含
 */
- (BOOL)ok_containsString:(NSString *)str;

/**
 * 是否是有效的范围(range不超过字符串长度)
 */
- (BOOL)ok_isValidRange:(NSRange)range;

/**
 * 字符串长度是否在给定的range范围内(闭区间)
 */
- (BOOL)ok_lengthInRange:(NSRange)range;

/**
 * 转化为字典
 */
- (NSDictionary *)jsonToDictionary;

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
/**
 *  @brief 倒序字符串
 *
 *  @param strSrc 输入
 *
 *  @return 倒序以后的字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

/**
 *  通过一个字符串拼接一个新的文件名
 *
 *  @param fileName 文件名
 *  @param newName  要拼接的名字
 *
 *  @return 新的文件名
 */
+ (NSString *)jointWithFileName:(NSString *)fileName newExtension:(NSString *)newName;


/**
 *  得到当前时间
 *
 *  @return yyyyMMddHHmmssSSS
 */
+ (NSString *)getNowDate;

/**
 *  获取属性文字
 *
 *  @param textArr   需要显示的文字数组,如果有换行请在文字中添加 "\n"换行符
 *  @param fontArr   字体数组, 如果fontArr与textArr个数不相同则获取字体数组中最后一个字体
 *  @param colorArr  颜色数组, 如果colorArr与textArr个数不相同则获取字体数组中最后一个颜色
 *  @param spacing   换行的行间距
 *  @param alignment 换行的文字对齐方式
 */
+ (NSMutableAttributedString *)getAttriStrByTextArray:(NSArray *)textArr
                                              fontArr:(NSArray *)fontArr
                                             colorArr:(NSArray *)colorArr
                                          lineSpacing:(CGFloat)spacing
                                            alignment:(NSTextAlignment)alignment;

@end

