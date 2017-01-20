//
//  NSDate+OKExtension.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (OKExtension)

- (NSString *)dateStringWithDateFormatter:(NSDateFormatter *)formatter;

+ (NSDate *)dateFromString:(NSString *)string withDateFormatter:(NSDateFormatter *)formatter;

@end
