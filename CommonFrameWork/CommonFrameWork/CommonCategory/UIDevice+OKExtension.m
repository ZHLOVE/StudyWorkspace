//
//  UIDevice+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "UIDevice+OKExtension.h"
#import "sys/sysctl.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation UIDevice (OKExtension)
/**
 *  获取设备型号
 */
+ (NSString*)ok_obtainDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

/**
 *  获取 手机系统 版本
 */
+ (NSString *)ok_obtainSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/**
 *  获取 屏幕像素
 */
+ (NSString *)ok_obtainScreen
{
    UIScreenMode *screenMode = [[UIScreen mainScreen] currentMode];
    return [NSString stringWithFormat:@"%.0fx%.0f",screenMode.size.width,screenMode.size.height];
}
/**
 *  获取 uuid  唯一标识
 */
+ (NSString *)ok_obtainUUID
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];

    return identifierForVendor;
}
/**
 *  获取IP地址
 */
+ (NSString *)ok_getIPAddress:(BOOL)preferIPv4{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;

    NSDictionary *addresses = [self ok_getIPAddresses];
    //NSLog(@"addresses: %@", addresses);

    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
+ (NSDictionary *)ok_getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];

    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }

    // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
    return [addresses count] ? addresses : nil;
}
@end
