//
//  OkdeerCrashHandle.m
//  OkdeerCommonLibrary
//
//  Created by zichen0422 on 16/12/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OkdeerCrashHandle.h"

@implementation OkdeerCrashHandle

static void handleRootException( NSException* exception )
{
    
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; // 将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSString *curDate = [fomatter stringFromDate:[NSDate date]];
    NSString *crashString = [NSString stringWithFormat:@"异常时间:%@\n %@\n%@\n%@",curDate,name,reason,symbols];
    NSString *crashPath = [[OkdeerCrashHandle alloc] obtainCrashPath];
    
    [crashString writeToFile:[NSString stringWithFormat:@"%@/%@.xml",crashPath,curDate] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

// ---
- (NSString *)obtainCrashPath
{
    NSString *cachePath = [NSString stringWithFormat:@"%@/Library/Caches", NSHomeDirectory()];
    NSString *directoryPath = [NSString stringWithFormat:@"%@/okdeerLocalCrash", cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directoryPath;
}

- (void)readCrashReportData
{
    dispatch_async(dispatch_queue_create("CrashQueue", NULL), ^{
        NSString *crashPath = [self obtainCrashPath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:crashPath];
        //列举目录内容，可以遍历子目录
        NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        NSString *curDate = [fomatter stringFromDate:[NSDate date]];
        NSString *curDayPath = [NSString stringWithFormat:@"%@.xml",curDate];
        
        NSString *nextPath = @"";
        while((nextPath = [myDirectoryEnumerator nextObject] )!=nil)
        {
            if (nextPath && nextPath.length && curDayPath && curDayPath.length) {
                if ([nextPath isEqualToString:curDayPath]) {
                    NSLog(@"%s---错误日志:--\n%@",__func__,[[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",crashPath,nextPath] encoding:NSUTF8StringEncoding error:nil]);
                }
                else {
                    NSString *filePath = [NSString stringWithFormat:@"%@/%@",crashPath, nextPath];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                    }
                }
            }
        }
    });
}

- (void)deleteCrashReportData
{
    NSString *filePath = [self obtainCrashPath];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

/**
 *  是否开启把错误日志保存到本地    默认不为开启
 */
- (void)openLocalCrashReportEnable:(BOOL)ret
{
#if defined(DEBUG)||defined(_DEBUG)
        
    if (ret) {
        NSSetUncaughtExceptionHandler( &handleRootException);
        [self readCrashReportData];
    }
    else {
        [self deleteCrashReportData];
    }
#endif
}

@end
