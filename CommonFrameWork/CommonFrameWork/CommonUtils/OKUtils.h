//
//  OKUtils.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKUtils : NSObject

/**
 *  创建文件夹
 */
+(NSString *)creatDirectoryRootPath:(NSString *)rootPath andDirectoryName:(NSString *)directoryName;

/**
 *  得到系统的缓存路径
 */
+ (NSString *)getCachePath;

/**
 *  得到根目录
 */
+ (NSString *)getDocumentPath;

/**
 * 获取tabbar目录的
 */
+ (NSString *)getTabBarDirectory;

@end
