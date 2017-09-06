//
//  NSString+OKFormatPrice.h
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/18.
//  Copyright © 2017年 OKDeer. All rights reserved.
//
//  价格的结算, 暂时提供价格的加减乘除,比较这些方法, 计算结果返回两位小数

#import <Foundation/Foundation.h>

@interface NSString (OKFormatPrice)


/**
 * 返回人民币符号 "￥"
 */
NSString * rmbSymbol();


/**
 格式化价格小数位
 
 @return 返回保留两位小数的价格
 */
NSString * formatPrice(NSString *price);

/**
 两个价格进行相加
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相加后保留两位小数的价格
 */
NSString * addingByPrice(NSString *price1, NSString *price2);


/**
 两个价格进行相减
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相减后保留两位小数的价格
 */
NSString * subtractingByPrice(NSString *price1, NSString *price2);


/**
 两个价格进行相乘
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相乘后保留两位小数的价格
 */
NSString * multiplyingByPrice(NSString *price1, NSString *price2);


/**
 两个价格进行相除
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相除后保留两位小数的价格
 */
NSString * dividingByPrice(NSString *price1, NSString *price2);


/**
 比较两个价格大小
 
 @param price1 价格1
 @param price2 价格2
 @return 比较后的结果
 */
NSComparisonResult comparePrice(NSString *price1, NSString *price2);

/**
 * 在输入时是否是正确的价格格式(注意:因为判断的是输入过程中的状态，以小数点结尾返回的是YES)
 */
- (BOOL)isValidInputingPrice ;

/**
 * 是否是有效的价格,小数点结尾返回为NO
 */
- (BOOL)isValidPrice ;

/**
 * 价格是否是小数点结尾，
 */
- (BOOL)isEndWithDotPrice ;


@end
