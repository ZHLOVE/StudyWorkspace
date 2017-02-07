//
//  NSDictionary+Extention.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (OKExtension)
/**
 * 转化为字符串
 */
- (NSString *)ok_toString;

/**
 * 根据字段的属性，生成字典的模型类代码
 */
- (void)propertyCode;

@end
