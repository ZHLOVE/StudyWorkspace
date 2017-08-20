//
//  OKCFunction.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKCFunction.h"

@implementation OKCFunction

/**
 获取bundle中的图片
 
 @param name 图片名字
 @return 图片
 */
UIImage* ImageFromBundleWithName(NSString *name)
{
    UIImage *getImage = [UIImage imageNamed:name];
    if (getImage) {
        return getImage;
    }
    
    //获取 mainBundle 所有的 bundle 文件夹
    NSArray *bundleArr = [[NSBundle mainBundle] pathsForResourcesOfType:@"bundle" inDirectory:nil];
    
    //排除第三方的bundle目录
    NSMutableArray *allBundleArr = [NSMutableArray arrayWithArray:bundleArr];
    if (allBundleArr.count>0) {
        NSString *bundlePrefix = [allBundleArr[0] lastPathComponent];
        [allBundleArr removeObjectsInArray:@[
         [NSString stringWithFormat:@"%@/%@",bundlePrefix,@"AlipaySDK.bundle"],
         [NSString stringWithFormat:@"%@/%@",bundlePrefix,@"AuthorizationBundel.bundle"],
         [NSString stringWithFormat:@"%@/%@",bundlePrefix,@"BuildingTalkBackBundle.bundle"],
         [NSString stringWithFormat:@"%@/%@",bundlePrefix,@"IPCLibary.bundle"],
         [NSString stringWithFormat:@"%@/%@",bundlePrefix,@"MJRefresh.bundle"],]];
    }
    
    //去自己的bundle下取图片
    for (NSString *bundlePath in allBundleArr) {
        getImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",bundlePath,name] inBundle:[NSBundle bundleForClass:NSClassFromString(@"OKCFunction")] compatibleWithTraitCollection:nil];
        if (getImage) {
            return getImage;
        }
        
        //遍历目录文件夹
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *folderArray = [fileManager contentsOfDirectoryAtPath:bundlePath error:nil];
        BOOL isDir = NO;
        
        for (NSString *subFolder in folderArray) {
            NSString *fullPath = [bundlePath stringByAppendingPathComponent:subFolder];
            [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
            
            //文件夹
            if (isDir) {
                getImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/%@",bundlePath,subFolder,name] inBundle:[NSBundle bundleForClass:NSClassFromString(@"OKCFunction")] compatibleWithTraitCollection:nil];
                if (getImage) {
                    return getImage;
                }
            }
        }
    }
    return getImage;
}

/**
 *  产生随机颜色
 */
UIColor* randomColor()
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/**
 *  获取应用版本号
 */
NSString* currentVersion()
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    if (!version) {
        version = @"IOS_X";
    }
    return version;
}

/**
 *  获取应用使用语音
 */
NSString* userLanguage()
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:@"userLanguage"];
    return language;
}

/**
 * 设置应用使用语音
 */
void setUserlanguage(NSString *language)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    [def synchronize];
}

NSString * dateString(NSDate *date)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

NSString * dateStringWithoutHMS(NSDate *date)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return [currentDateStr componentsSeparatedByString:@" "].firstObject;
}

NSDate *dateFromString(NSString *str)
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    /** 直接指定时区--东八区*/
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];
    [dateFormatter setTimeZone:GTMzone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}


@end
