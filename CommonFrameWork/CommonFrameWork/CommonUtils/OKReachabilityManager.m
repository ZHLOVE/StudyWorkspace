//
//  OKReachabilityManager.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/1/9.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKReachabilityManager.h"
#import <objc/runtime.h>

/** 没有网络通知key */
static NSString * const kNetWorkStatusChangeNotification = @"kNetWorkStatusChangeNotification";

/** 记住上一次的网络状态key */
static char const * const kRememberReachabilityStatusKey = "kRememberReachabilityStatusKey";


@implementation OKReachabilityManager

+(void)load
{
    //开始监听网络
    [self startMonitoringOKReachability];
}

/**
 *  开始监听网络状态
 */
+ (void)startMonitoringOKReachability
{
    AFNetworkReachabilityManager *reachManager = [AFNetworkReachabilityManager sharedManager];
    [reachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //记住改变网络后的网络状态
        objc_setAssociatedObject([AFNetworkReachabilityManager sharedManager], kRememberReachabilityStatusKey, @(status), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        //如果其他地方需要监听网络,可以发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetWorkStatusChangeNotification object:nil];
    }];
    [reachManager startMonitoring];
}


/**
 *  监听网络改变回调
 */
+ (void)reachabilityChangeBlock:(void (^)(AFNetworkReachabilityStatus currentStatus, AFNetworkReachabilityStatus beforeStatus))block
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        
        id obj = objc_getAssociatedObject(manager, kRememberReachabilityStatusKey);
        if (obj) {
            AFNetworkReachabilityStatus oldStatus = [obj integerValue];
            if (block) {
                block(status,oldStatus);
            }
        } else {
            if (block) {
                block(status,AFNetworkReachabilityStatusUnknown);
            }
        }
        
        //记住改变网络后的网络状态
        objc_setAssociatedObject(manager, kRememberReachabilityStatusKey, @(status), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }];
}

/**
 *  网络是否可用
 */
+ (BOOL)isReachable
{
    BOOL reachable = [AFNetworkReachabilityManager sharedManager].isReachable;
    return reachable;
}

/**
 *  是否为手机运营商网络
 */
+ (BOOL)isReachableViaWWAN
{
    BOOL isWWAN = [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN;
    return isWWAN;
}

/**
 *  是否WIFI网络
 */
+ (BOOL)isReachableViaWiFi
{
    BOOL isWiFi = [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi;
    return isWiFi;
}

@end
