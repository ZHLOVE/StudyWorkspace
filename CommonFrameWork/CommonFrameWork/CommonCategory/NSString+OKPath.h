//
//  NSString+OKPath.h
//  Pods
//
//  Created by 雷祥 on 2017/3/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (OKPath)


/**
 *  判断该路径下是否有文件
 *
 *  @return 返回布尔值
 */
+(BOOL)ok_isExistFileForPath:(NSString *)path;

/**
 *  得到系统的缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)ok_cachePath;

/**
 *  得到根目录
 */
+ (NSString *)ok_documentPath;


/**
 *  删除缓存文件夹
 */
+ (void)ok_deleteFilesInCacheDirectory;

/**
 *  清除文件夹下所有的文件及文件夹
 *
 *  @param directory 所要删除的文件夹目录
 */
+(void)ok_deleteFilesInDirectory:(NSString *)directory;

/**
 *  防止上传到icloud
 */
+ (BOOL)ok_addSkipBackupAttributeToItemAtURL:(NSURL *)URL bundleIdentifier:(NSString *)bundleIdentifier;

/**
 *  创建document文件夹下的不删除的base文件夹
 */
+(NSString *)ok_documentBaseDirectory;

/**
 *  创建文件夹
 *
 *  @param rootPath      路径，必须是文件夹路径
 *  @param directoryName 路径下面的文件夹名字
 *
 *  @return 返回整个文件夹的路径
 */
+(NSString *)ok_creatDirectoryRootPath:(NSString *)rootPath andDirectoryName:(NSString *)directoryName;


/**
 *  删除文件或文件夹
 *
 *  @param filePath 需要删除的路径
 */
+(BOOL)ok_deleteFileAtPath:(NSString *)filePath;

@end
