//
//  NSObject+OKPrintModelProperty.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/2/28.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OKPrintModelProperty)

/**
 * 根据字典模型打印出指定模型类的属性字符串
 *
 * @param dict 字典
 * @param className 模型类string
 */
+ (void)printModelPropertyWithDic:(NSDictionary *)dict modelClass:(NSString *)className;

@end
