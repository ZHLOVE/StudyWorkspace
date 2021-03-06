//
//  UIDevice+OKExtension.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (OKExtension)
/**
 *  获取设备型号
 */
+ (NSString*)ok_obtainDevicePlatform;
/**
 *  获取 手机版本
 */
+ (NSString *)ok_obtainSystemVersion;
/**
 *  获取 屏幕像素
 */
+ (NSString *)ok_obtainScreen;
/**
 *  获取 uuid  唯一标识
 */
+ (NSString *)ok_obtainUUID;
/**
 *  获取IP地址
 */
+ (NSString *)ok_getIPAddress:(BOOL)preferIPv4;
/**
 *  获取IP地址信息
 */
+ (NSDictionary *)ok_getIPAddresses;
/**
 *  获取设置推送声音状态
 */
+ (BOOL)ok_isNotifySound;

/**
 *  获取时间戳  毫秒
 *
 *  @return 毫秒
 */
+ (NSString *)ok_obtainTimeInterval;
@end
