//
//  NSString+OKPath.m
//  Pods
//
//  Created by 雷祥 on 2017/3/15.
//
//

#import "NSString+OKPath.h"
#include <sys/xattr.h>

@implementation NSString (OKPath)
/**
 *  判断该路径下是否有文件
 *
 *  @param path
 *
 *  @return 返回布尔值
 */
+(BOOL)ok_isExistFileForPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}
/**
 *  得到系统的缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)ok_cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
/**
 *  得到根目录
 *
 *  @return
 */
+ (NSString *)ok_documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


/**
 *  删除缓存文件夹
 *
 *  @return
 */
+ (void)ok_deleteFilesInCacheDirectory{    //删除缓存文件夹的可删除文件夹
    [[NSFileManager defaultManager] removeItemAtPath:[self ok_cachePath] error:nil];
}
/**
 *  清除文件夹下所有的文件及文件夹
 *
 *  @param directory 所要删除的文件夹目录
 */
+(void)ok_deleteFilesInDirectory:(NSString *)directory{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *contents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
    }
}
/**
 *  防止上传到icloud
 */
+ (BOOL)ok_addSkipBackupAttributeToItemAtURL:(NSURL *)URL bundleIdentifier:(NSString *)bundleIdentifier
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = [bundleIdentifier UTF8String];
    u_int8_t attrValue = 1;

    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

/**
 *  创建document文件夹下的不删除的base文件夹
 *
 *  @return
 */
+(NSString *)ok_documentBaseDirectory{
    NSString *documentBaseDirectory = [NSString stringWithFormat:@"%@/Documents/CloudCityBase", NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:documentBaseDirectory isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:documentBaseDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentBaseDirectory;
}

/**
 *  创建文件夹
 *
 *  @param rootPath      路径，必须是文件夹路径
 *  @param directoryName 路径下面的文件夹名字
 *
 *  @return 返回整个文件夹的路径
 */
+(NSString *)ok_creatDirectoryRootPath:(NSString *)rootPath andDirectoryName:(NSString *)directoryName{

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
 *  获取录音的文件夹
 */
+(NSString *)ok_getRecordDirectory{
    NSString *path = [NSString stringWithFormat:@"%@/Record",[self ok_cachePath]];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

/**
 *  删除文件或文件夹
 *
 *  @param filePath 需要删除的路径
 *
 *  @return
 */
+ (BOOL)ok_deleteFileAtPath:(NSString *)filePath{
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
@end
