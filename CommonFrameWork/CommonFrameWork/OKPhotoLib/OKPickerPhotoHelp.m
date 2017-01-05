//
//  OKPickerPhotoHelp.m
//  ChoosePhotoAlbumDemo
//
//  Created by mao wangxin on 2016/12/31.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "OKPickerPhotoHelp.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface OKPickerPhotoHelp ()<UIImagePickerControllerDelegate>
@property (nonatomic, copy) void (^complete)(UIImage *selectImage);
@end

@implementation OKPickerPhotoHelp

/**
 选择相册图片 <选择图片入口>
 
 @param superVC 从哪个控制器跳转进来
 @param maxCount 选择最大的图片数
 @param complete 选择完成后的回调
 */
+ (void)showImagePickerController:(UIViewController *)superVC maxCount:(NSInteger)maxCount pickerType:(PickerPhotoStatus)pickerType selectedImageComplete:(void (^)(NSArray<ZLPhotoAssets *> *status))complete
{
    if (![superVC isKindOfClass:[UIViewController class]]) return;
    
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // MaxCount, Default = 9
    pickerVc.maxCount = maxCount<1 ? 1 : maxCount;
    // Jump AssetsVc
    pickerVc.status = PickerViewShowStatusSavePhotos;
    // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
    pickerVc.photoStatus = pickerType;
    // Recoder Select Assets
    pickerVc.selectPickers = nil;//传一个数组,每次进入时显示已选择的照片;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = NO;//是否置顶展示图片
    pickerVc.isShowCamera = NO;//第一张时是否显示拍照
    // CallBack
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        if (complete) {
            NSArray *selectedImageArr = status.mutableCopy;
            complete(selectedImageArr);
        }
    };
    [pickerVc showPickerVc:superVC];
}


/**
 使用照相机拍照 <注意:此方法为实例方法,当前实例需要在页面上使用变量强引用,否则便不能拉起拍照页面>
 
 @param superVC 从哪个控制器跳转进来
 @param complete 拍照完成的回调方法
 */
- (void)showCameraController:(UIViewController *)superVC selectedImageComplete:(void (^)(UIImage *selectImage))complete
{
    //可用自己项目共用类 modify by maowangxin
    if (![OKPickerPhotoHelp checkAuthorizationStatusTypeCamera:YES]) return;
    self.complete = complete;
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate = (id)self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [superVC presentViewController:imagePicker animated:YES completion:nil];
    }
}

/**
 * 相机选择完成回调
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.complete) {
        //相机添加图片.
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.complete(image);
    }
}

/*
 *  判断有没开启相机权限
 *
 *  @return yes 为开启中  no 没有开启
 */
+ (BOOL)checkAuthorizationStatusTypeCamera:(BOOL)isAlert{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    BOOL isAuthor = YES;
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        isAuthor = NO;
    }
    if (isAlert && !isAuthor) {
        NSString *name = @"";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您没开启相机功能 请在设置->隐私->相机->%@ 设置为打开状态",name] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
    
    return isAuthor;
}

@end
