//
//  OKPickerPhotoHelp.h
//  ChoosePhotoAlbumDemo
//
//  Created by mao wangxin on 2016/12/31.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLPhotoPickerViewController.h"

@interface OKPickerPhotoHelp : NSObject

/**
 选择相册图片
 
 @param superVC 从哪个控制器跳转进来
 @param maxCount 选择最大的图片数
 @param pickerType 跳转类型: 相薄,多选图片,拍照
 @param complete 如果是非拍照类型进来,则返回选择照片完成的回调
 */
+ (void)showImagePickerController:(UIViewController *)superVC
                         maxCount:(NSInteger)maxCount
                       pickerType:(PickerPhotoStatus)pickerType
            selectedImageComplete:(void (^)(NSArray<ZLPhotoAssets *> *status))complete;

/**
 使用照相机拍照 <注意:此方法为实例方法,当前实例需要在页面上使用变量强引用,否则便不能拉起拍照页面>
 
 @param superVC 从哪个控制器跳转进来
 @param complete 拍照完成的回调方法
 */
- (void)showCameraController:(UIViewController *)superVC
       selectedImageComplete:(void (^)(UIImage *selectImage))complete;


@end
