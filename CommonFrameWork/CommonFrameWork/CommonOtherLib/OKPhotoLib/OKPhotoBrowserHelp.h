//
//  OKPhotoBrowserHelp.h
//  ChoosePhotoAlbumDemo
//
//  Created by mao wangxin on 2016/12/31.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLPhotoPickerBrowserViewController.h"

@interface OKPhotoBrowserHelp : NSObject

/**
 图片浏览器

 @param superVC 展示图片的控制器
 @param currentIndex 展示数组中的当前页数
 @param photos 展示的图片数组, 里面元素存放 <ZLPhotoPickerBrowserPhoto>对象
 */
+ (void)showPhotoBrowser:(UIViewController *)superVC
            currentIndex:(NSInteger)currentIndex
                  photos:(NSArray<ZLPhotoPickerBrowserPhoto *>*)photos;

@end
