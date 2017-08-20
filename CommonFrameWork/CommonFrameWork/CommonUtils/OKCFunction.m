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
        [allBundleArr removeObjectsInArray:@[[NSString stringWithFormat:@"%@/%@",bundlePrefix,@"AlipaySDK.bundle"],
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
            NSLog(@"bundlepath===%@====%@",bundlePath,subFolder);
            NSString *fullPath = [bundlePath stringByAppendingPathComponent:subFolder];
            [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
            if (isDir) { //文件夹
                
                getImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/%@",bundlePath,subFolder,name] inBundle:[NSBundle bundleForClass:NSClassFromString(@"OKCFunction")] compatibleWithTraitCollection:nil];
                if (getImage) {
                    return getImage;
                }
            }
        }
    }
    
    return getImage;
}


@end
