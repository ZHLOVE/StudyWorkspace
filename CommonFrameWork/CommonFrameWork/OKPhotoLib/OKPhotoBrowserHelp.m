//
//  OKPhotoBrowserHelp.m
//  ChoosePhotoAlbumDemo
//
//  Created by mao wangxin on 2016/12/31.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "OKPhotoBrowserHelp.h"

@implementation OKPhotoBrowserHelp

+ (void)showPhotoBrowser:(UIViewController *)superVC currentIndex:(NSInteger)currentIndex photos:(NSArray<ZLPhotoPickerBrowserPhoto *>*)photos
{
    ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
    browserVc.photos = photos;
    browserVc.editing = NO;
    browserVc.currentIndex = currentIndex;
    [browserVc showPickerVc:superVC];
}


@end
