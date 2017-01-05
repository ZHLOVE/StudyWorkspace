//
//  NSString+Extention.m
//  基础框架类
//
//  Created by 雷祥 on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSString+OKExtention.h"
#import <UIKit/UIKit.h>

@implementation NSString (OKExtention)
/**
 * 判断是否包含
 */
-(BOOL)ok_containsString:(NSString *)str {
    //不是字符串
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }

    if ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0) {
        return [self containsString:str];
    }
    else {
        NSRange range = [str rangeOfString:self];
        if (range.location == NSNotFound) {
            return NO;
        }
        else {
            return YES;
        }
    }
}

/**
 * 是否时有效的范围
 */
- (BOOL)ok_isValidRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        return NO;
    }
    else {
        return YES;
    }
}

/**
 * 字符串长度是否在给定的range范围内
 */
- (BOOL)ok_lengthInRange:(NSRange)range {
    if (self.length >= range.location && self.length <= (range.location + range.length)) {
        return YES;
    }
    else {
        return NO;
    }
}

/**
 * 转化为字典
 */
- (NSDictionary *)toDictionary {
    NSData *jsonData = [self dataUsingEncoding:(NSUTF8StringEncoding)];
    NSError *errer;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&errer];
    if (errer) {
        return nil;
    }

    return dic;
}


@end
