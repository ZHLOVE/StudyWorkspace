//
//  NSDate+OKExtension.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (OKExtension)


- (NSString *)dateStringWithDateFormatter:(NSDateFormatter *)formatter;

+ (NSDate *)dateFromString:(NSString *)string withDateFormatter:(NSDateFormatter *)formatter;

- (OKDateItem *)ok_timeIntervalSinceDate:(NSDate *)anotherDate;

- (BOOL)ok_isToday;

- (BOOL)ok_isYesterday;

- (BOOL)ok_isTomorrow;

- (BOOL)ok_isThisYear;

/**
 *  得到当前时间 格式：yyyyMMddHHmmssSSS
 */
+ (NSString *)nowDate;

//获取今天周几
+ (NSInteger)nowWeekday;
@end

