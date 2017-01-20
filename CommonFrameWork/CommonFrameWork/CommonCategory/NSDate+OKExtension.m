//
//  NSDate+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSDate+OKExtension.h"

@implementation NSDate (OKExtension)

- (NSString *)dateStringWithDateFormatter:(NSDateFormatter *)formatter {
    if (!formatter) {
        return nil;
    }

    return [formatter stringFromDate:self];
}


+ (NSDate *)dateFromString:(NSString *)string withDateFormatter:(NSDateFormatter *)formatter {
    if (!string.length || !formatter) {
        return nil;
    }

    return [formatter dateFromString:string];
}


//- (NSInteger)


@end
