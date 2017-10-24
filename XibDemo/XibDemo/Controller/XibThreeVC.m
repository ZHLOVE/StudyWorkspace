//
//  ThreeViewController.m
//  XibDemo
//
//  Created by mao wangxin on 2017/2/28.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "XibThreeVC.h"

@interface XibThreeVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation XibThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"self.scrollView==%@\nself.view==%@",self.scrollView,self.view);
    
//    CGRect rect = self.scrollView.frame;
//    rect.origin.y = 0;
//    rect.size.height = self.view.bounds.size.height;
//    self.scrollView.frame = rect;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //打开系统的设置的各个界面
    [self openGeneral];
}

//打开系统的设置的各个界面
//http://www.jianshu.com/p/df41dffc43e5 (9.0之前的)
//http://blog.csdn.net/spicyShrimp/article/details/69946396 (大于9.0的)

//Wi-Fi: App-Prefs:root=WIFI
//蓝牙: App-Prefs:root=Bluetooth
//蜂窝移动网络: App-Prefs:root=MOBILE_DATA_SETTINGS_ID
//个人热点: App-Prefs:root=INTERNET_TETHERING
//运营商: App-Prefs:root=Carrier
//通知: App-Prefs:root=NOTIFICATIONS_ID
//通用: App-Prefs:root=General
//通用-关于本机: App-Prefs:root=General&path=About
//通用-键盘: App-Prefs:root=General&path=Keyboard
//通用-辅助功能: App-Prefs:root=General&path=ACCESSIBILITY
//通用-语言与地区: App-Prefs:root=General&path=INTERNATIONAL
//通用-还原: App-Prefs:root=Reset
//墙纸: App-Prefs:root=Wallpaper
//Siri: App-Prefs:root=SIRI
//隐私: App-Prefs:root=Privacy
//定位: App-Prefs:root=LOCATION_SERVICES
//Safari: App-Prefs:root=SAFARI
//音乐: App-Prefs:root=MUSIC
//音乐-均衡器: App-Prefs:root=MUSIC&path=com.apple.Music:EQ
//照片与相机: App-Prefs:root=Photos
//FaceTime: App-Prefs:root=FACETIME
//...

// 打开系统的设置界面,当系统大于10的时候直接打开当前App的设置界面
- (void)openGeneral
{
    //App的设置界面URL: UIApplicationOpenSettingsURLString
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=NOTIFICATIONS_ID"];

    //私有API注意首字母改成了大写
    //    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
    //    [[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(openSensitiveURL:withOptions:) withObject:url withObject:nil];

    //网上貌似说是 非私有API
    if ([[UIApplication sharedApplication] canOpenURL:url]) {

        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
