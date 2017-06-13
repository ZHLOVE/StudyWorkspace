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
 * 根据字典模型打印出指定模型类的每个@property属性字符串,
 * 方便在创建实体Model模型时直接粘贴打印出来的字符串即可
 *
 * @param className 模型类名称string
 */
- (void)printPropertyWithClassName:(NSString *)className;

@end
