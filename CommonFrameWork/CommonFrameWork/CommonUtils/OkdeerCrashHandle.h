//
//  OkdeerCrashHandle.h
//  OkdeerCommonLibrary
//
//  Created by zichen0422 on 16/12/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

/**
 *  Crash 日志处理, 默认保留当天的Crash日志
 *  Debug 可以打开/关闭这个功能.
 *  Release 模式关闭
 */

#import <Foundation/Foundation.h>

@interface OkdeerCrashHandle : NSObject

/**
 *  是否开启把错误日志保存到本地    默认不为开启
 */
- (void)openLocalCrashReportEnable:(BOOL)ret;


@end
