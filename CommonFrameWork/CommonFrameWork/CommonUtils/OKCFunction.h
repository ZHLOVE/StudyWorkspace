//
//  OKCFunction.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OKCFunction : NSObject

/**
 获取bundle中的图片
 
 @param name 图片名字
 @return 图片
 */
UIImage* ImageFromBundleWithName(NSString *name);

/**
 *  产生随机颜色
 */
UIColor* randomColor(void);

/**
 *  获取应用版本号
 */
NSString* currentVersion(void);

/**
 *  获取应用使用语音
 */
NSString* userLanguage(void);

/**
 * 设置应用使用语音
 */
void setUserlanguage(NSString *language);

/**
 * 获取时间
 */
NSString *dateString(NSDate *date);

/**
 * 获取时间
 */
NSString *dateStringWithoutHMS(NSDate *date);

/**
 * 获取时间
 */
NSDate *dateFromString(NSString *str);

@end
