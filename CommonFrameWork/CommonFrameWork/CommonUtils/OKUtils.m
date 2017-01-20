//
//  OKUtils.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKUtils.h"
#import "OKPublicConst.h"

@implementation OKUtils

/**
 *  创建文件夹
 *
 *  @param rootPath      路径，必须是文件夹路径
 *  @param directoryName 路径下面的文件夹名字
 *
 *  @return 返回整个文件夹的路径
 */
+(NSString *)creatDirectoryRootPath:(NSString *)rootPath andDirectoryName:(NSString *)directoryName{
    
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@", rootPath,directoryName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directoryPath;
}

/**
 *  得到系统的缓存路径
 */
+ (NSString *)getCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  得到根目录
 */
+ (NSString *)getDocumentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 * 获取tabbar目录的
 */
+ (NSString *)getTabBarDirectory{
    return [OKUtils creatDirectoryRootPath:[OKUtils getCachePath] andDirectoryName:kOKabBarImagePathKey];
}


@end
