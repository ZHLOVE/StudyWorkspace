//
//  AppDelegate.m
//  MutableTargetDemo
//
//  Created by mao wangxin on 2017/9/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

#define iOS8UP      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS10UP     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //注册远程通知
    [self registRemoteNotification:application];
    return YES;
}

/**
 * 获取 iphoneToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //推送分类中的方法保存Token
    [self saveDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    CCLog(@"获取token失败，开发调试的时候需要关注，必要的情况下将其上传到异常统计");
}

/**
 * iOS10UP 代理回调方法，通知即将展示的时候
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    UNNotificationRequest *request = notification.request; // 原始请求
    NSDictionary * userInfo = notification.request.content.userInfo;//userInfo数据
    CCLog(@"通知即将展示的时候===\n%@===\n%@===\n%@===\n%@",request,center,notification.request.content,userInfo);
    
    // 回调block，将设置传入
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

/**
 * iOS10UP 用户与通知进行交互后的response，比如说用户直接点开通知打开App、用户点击通知的按钮或者进行输入文本框的文本
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler{
    
    UNNotificationRequest *request = response.notification.request; // 原始请求
    NSDictionary * userInfo = response.notification.request.content.userInfo;//userInfo数据
    CCLog(@"用户与通知进行交互后===\n%@===\n%@===\n%@",request,request.content,userInfo);
}

/**
 *  注册远程通知
 */
- (void)registRemoteNotification:(UIApplication *)application
{
    if (iOS8UP) {
        if (iOS10UP) { // ios_version >= 10.0
            //系统大于10.0注册推送
            [self registerrNotificationFromiOS10UP:application];
            
        } else { // 8.0 <= ios_version < 10.0
            UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:notiSettings];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        
    } else{ // ios_version < 8.0
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
#endif
    }
}

#pragma mark -===========处理iOS 10.0推送===========/** * 系统大于10.0注册推送 */

/**
 * 系统大于10.0注册推送
 */
- (void)registerrNotificationFromiOS10UP:(UIApplication *)application
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    // 必须写代理，不然无法监听通知的接收与点击
    center.delegate = self;
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            CCLog(@"用户授权向APNs注册，获取deviceToken");
            [application registerForRemoteNotifications];
        } else {
            CCLog(@"用户拒绝推送消息，注册通知失败==%@",error);
        }
    }];
}

#pragma mark -===========保存远程推送deviceToken===========

/**
 * 保存deviceToken
 */
- (void)saveDeviceToken:(NSData *)deviceToken {
    NSString *descToken = [deviceToken description];
    NSString *replaceLeftChar = [descToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSString *replaceRightChar = [replaceLeftChar stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSString *factToken = [replaceRightChar stringByReplacingOccurrencesOfString:@" " withString:@""];
    CCLog(@"远程推送deviceToken=====%@",factToken);
}

@end
