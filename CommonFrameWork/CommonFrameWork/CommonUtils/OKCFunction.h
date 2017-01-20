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

@end
