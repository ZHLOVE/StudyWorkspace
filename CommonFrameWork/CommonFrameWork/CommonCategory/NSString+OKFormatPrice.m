//
//  NSString+OKFormatPrice.m
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/18.
//  Copyright © 2017年 OKDeer. All rights reserved.
//

#import "NSString+OKFormatPrice.h"

typedef enum : NSUInteger {
    AddingType,            //加
    SubtractingType,       //减
    MultiplyingType,       //乘
    DividingType,          //除
} PriceCalculateType;


@implementation NSString (OKFormatPrice)

/**
 * 返回人民币符号 "￥"
 */
NSString * rmbSymbol(){
    return @"￥";
}

/**
 * 保留两位小数的格式化句柄
 */
NSDecimalNumberHandler * decimalNumberHandler()
{
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                  scale:2
                                                       raiseOnExactness:NO
                                                        raiseOnOverflow:NO
                                                       raiseOnUnderflow:NO
                                                    raiseOnDivideByZero:YES];
}

/**
 格式化价格小数位
 
 @return 返回保留两位小数的价格
 */
NSString * formatPrice(NSString *price)
{
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:price];
    
    NSDecimalNumber *formatValue = [decimalNumber decimalNumberByRoundingAccordingToBehavior:decimalNumberHandler()];
    return [NSString stringWithFormat:@"%@",formatValue];
}

/**
 计算价格
 
 @param price1 价格1
 @param price2 价格2
 @param calculateType 计算方式
 @return 返回计算价格后保留两位小数的价格
 */
NSString * calculatePrice(NSString *price1, NSString *price2, PriceCalculateType calculateType)
{
    NSDecimalNumber *decimalPrice1 = [NSDecimalNumber decimalNumberWithString:price1];
    NSDecimalNumber *decimalPrice2 = [NSDecimalNumber decimalNumberWithString:price2];
    NSDecimalNumber *resultValue = nil;
    
    NSDecimal a = decimalPrice1.decimalValue;
    NSDecimal b = decimalPrice2.decimalValue;
    NSDecimal result;
    
    switch (calculateType) {
            case AddingType: //price1 加 price2
        {
            NSCalculationError success = NSDecimalAdd(&result, &a, &b, NSRoundPlain);
            if (success == NSCalculationNoError) {
                resultValue = [decimalPrice1 decimalNumberByAdding:decimalPrice2
                                                      withBehavior:decimalNumberHandler()];
            } else {
                NSLog(@"价格相加出错===%zd",success);
                return @"";
            }
        }
            break;
            case SubtractingType:  //price1 减 price2
        {
            NSCalculationError success = NSDecimalSubtract(&result, &a, &b, NSRoundPlain);
            if (success == NSCalculationNoError) {
                resultValue = [decimalPrice1 decimalNumberBySubtracting:decimalPrice2
                                                           withBehavior:decimalNumberHandler()];
            } else {
                NSLog(@"价格相减出错===%zd",success);
                return @"";
            }
        }
            break;
            case MultiplyingType:  //price1 乘 price2
        {
            NSCalculationError success = NSDecimalMultiply(&result, &a, &b, NSRoundPlain);
            if (success == NSCalculationNoError) {
                resultValue = [decimalPrice1 decimalNumberByMultiplyingBy:decimalPrice2
                                                             withBehavior:decimalNumberHandler()];
            } else {
                NSLog(@"价格相乘出错===%zd",success);
                return @"";
            }
        }
            break;
            case DividingType: //price1 除 price2
        {
            NSCalculationError success = NSDecimalDivide(&result, &a, &b, NSRoundPlain);
            if (success == NSCalculationNoError) {
                resultValue = [decimalPrice1 decimalNumberByDividingBy:decimalPrice2
                                                          withBehavior:decimalNumberHandler()];
            } else {
                NSLog(@"价格相除出错===%zd",success);
                return @"";
            }
        }
            break;
        default:
            break;
    }
    
    if (resultValue) {
        //上面的计算结果已经做了四舍五入, 但是结果小于两位小数的 或整数的,没有保留两位小数,下面做补0处理
        NSString *resultPrice = [NSString stringWithFormat:@"%@",resultValue];
        if ([resultPrice containsString:@"."]) {
            NSArray *valueArr = [resultPrice componentsSeparatedByString:@"."];
            if (valueArr.count>1) {
                NSString *pointValue = [valueArr lastObject];
                if (pointValue.length == 0) {
                    return [NSString stringWithFormat:@"%@00",resultValue];
                    
                } else if (pointValue.length == 1) {
                    return [NSString stringWithFormat:@"%@0",resultValue];
                }
            }
            return resultPrice;
        } else {
            return [NSString stringWithFormat:@"%@.00",resultValue];
        }
    } else {
        NSLog(@"价格计算类型不在 <加,减,乘,除> 中");
        return @"";
    }
}

/**
 两个价格进行相加
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相加后保留两位小数的价格
 */
NSString * addingByPrice(NSString *price1, NSString *price2){
    return calculatePrice(price1, price2, AddingType);
}

/**
 两个价格进行相减
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相减后保留两位小数的价格
 */
NSString * subtractingByPrice(NSString *price1, NSString *price2){
    return calculatePrice(price1, price2, SubtractingType);
}

/**
 两个价格进行相乘
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相乘后保留两位小数的价格
 */
NSString * multiplyingByPrice(NSString *price1, NSString *price2){
    return calculatePrice(price1, price2, MultiplyingType);
}

/**
 两个价格进行相除
 
 @param price1 价格1
 @param price2 价格2
 @return 返回相除后保留两位小数的价格
 */
NSString * dividingByPrice(NSString *price1, NSString *price2){
    return calculatePrice(price1, price2, DividingType);
}

/**
 比较两个价格大小

 @param price1 价格1
 @param price2 价格2
 @return 比较后的结果
 */
NSComparisonResult comparePrice(NSString *price1, NSString *price2)
{
    NSDecimalNumber*discount1 = [NSDecimalNumber decimalNumberWithString:price1];
    NSDecimalNumber*discount2 = [NSDecimalNumber decimalNumberWithString:price2];
    NSComparisonResult result = [discount1 compare:discount2];
    
    if (result ==NSOrderedAscending) {
        NSLog(@"price1 < price2");
        
    } else if (result == NSOrderedSame) {
        NSLog(@"price1 == price2");
        
    } else if (result == NSOrderedDescending) {
        NSLog(@"price1 > price2");
    }
    return result;
}

/**
 * 在输入时是否是正确的价格格式(注意:因为判断的是输入过程中的状态，以小数点结尾返回的是YES)
 */
- (BOOL)isValidInputingPrice {
    NSString *regex = @"^(0|[1-9][0-9]{0,9})(\\.[0-9]{0,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}


/**
 * 是否是有效的价格
 */
- (BOOL)isValidPrice{
    NSString *regex = @"^(0|[1-9][0-9]{0,9})(\\.[0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 价格是否是小数点结尾，
 */
- (BOOL)isEndWithDotPrice {
    NSString *regex = @"[0-9]+\\.$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}


@end
