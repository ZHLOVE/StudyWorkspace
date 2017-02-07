//
//  NSDate+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSDate+OKExtension.h"

static NSDateFormatter *_okFormatter = nil;

@implementation OKDateItem
- (NSString *)description
{
    return [NSString stringWithFormat:@"%zd天%zd小时%zd分%zd秒", self.day, self.hour, self.minute, self.second];
}
@end


@implementation NSDate (OKExtension)

/**
 *  创建静态时间格式化
 */
+ (void)initialize
{
    //因为官方说明，时间格式化类很耗时，所以初始化一个公用时间格式化类
    _okFormatter = [[NSDateFormatter alloc] init];
}

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

- (OKDateItem *)ok_timeIntervalSinceDate:(NSDate *)anotherDate
{
    // createdAtDate和nowDate之间的时间间隔
    NSTimeInterval interval = [self timeIntervalSinceDate:anotherDate];
    
    OKDateItem *item = [[OKDateItem alloc] init];
    
    // 相差多少天
    int intInterval = (int)interval;
    int secondsPerDay = 24 * 3600;
    item.day = intInterval / secondsPerDay;
    
    // 相差多少小时
    int secondsPerHour = 3600;
    item.hour = (intInterval % secondsPerDay) / secondsPerHour;
    
    // 相差多少分钟
    int secondsPerMinute = 60;
    item.minute = ((intInterval % secondsPerDay) % secondsPerHour) / secondsPerMinute;
    
    // 相差多少秒
    item.second = ((intInterval % secondsPerDay) % secondsPerHour) % secondsPerMinute;
    
    return item;
}

- (BOOL)ok_isToday
{
    // 判断self这个日期对象是否为今天
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 如果selfCmps和nowCmps的所有元素都一样，就返回YES，否则返回NO
    return [selfCmps isEqual:nowCmps];
    //    return selfCmps.year == nowCmps.year
    //    && selfCmps.month == nowCmps.month
    //    && selfCmps.day == nowCmps.day;
}


- (BOOL)ok_isYesterday
{
    // 判断self这个日期对象是否为昨天
    
    // self 2015-12-09 22:10:01 -> 2015-12-09 00:00:00
    // now  2015-12-10 12:10:01 -> 2015-12-01 00:00:00
    // 昨天：0year 0month 1day 0hour 0minute 0second
    
    
    // NSDate * -> NSString * -> NSDate *
    
    _okFormatter.dateFormat = @"yyyyMMdd";
    
    // 生成只有年月日的字符串对象
    NSString *selfString = [_okFormatter stringFromDate:self];
    NSString *nowString = [_okFormatter stringFromDate:[NSDate date]];
    
    // 生成只有年月日的日期对象
    NSDate *selfDate = [_okFormatter dateFromString:selfString];
    NSDate *nowDate = [_okFormatter dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

- (BOOL)ok_isTomorrow
{
    _okFormatter.dateFormat = @"yyyyMMdd";
    
    // 生成只有年月日的字符串对象
    NSString *selfString = [_okFormatter stringFromDate:self];
    NSString *nowString = [_okFormatter stringFromDate:[NSDate date]];
    
    // 生成只有年月日的日期对象
    NSDate *selfDate = [_okFormatter dateFromString:selfString];
    NSDate *nowDate = [_okFormatter dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

- (BOOL)ok_isThisYear
{
    // 判断self这个日期对象是否为今年
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger selfYear = [calendar components:NSCalendarUnitYear fromDate:self].year;
    NSInteger nowYear = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]].year;
    
    return selfYear == nowYear;
}

/**
 *  得到当前时间
 *
 *  @return yyyyMMddHHmmssSSS
 */
+ (NSString *)nowDate
{
    NSDate *senddate = [NSDate date];
    [_okFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [_okFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *locationString = [_okFormatter stringFromDate:senddate];
    return locationString;
}


//获取今天周几
+ (NSInteger)nowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps day];
}
@end

