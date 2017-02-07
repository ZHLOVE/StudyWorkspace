//
//  OKLocalNotification.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/2/7.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKLocalNotification : NSObject

+ (NSDate *)fireDateWithWeek:(NSInteger)week
                        hour:(NSInteger)hour
                      minute:(NSInteger)minute
                      second:(NSInteger)second;

//本地发送推送（先取消上一个 再push现在的）
+ (void)localPushForDate:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
             alertAction:(NSString *)alertAction
               soundName:(NSString *)soundName
             launchImage:(NSString *)launchImage
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval;

#pragma mark - 退出
+ (void)cancelAllLocalPhsh;

+ (void)cancleLocalPushWithKey:(NSString *)key;

@end

