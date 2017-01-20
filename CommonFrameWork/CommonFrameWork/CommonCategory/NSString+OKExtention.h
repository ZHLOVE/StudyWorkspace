//
//  NSString+Extention.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

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
- (NSDictionary *)toDictionary ;


@end
