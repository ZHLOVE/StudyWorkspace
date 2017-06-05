//
//  DrawTabBarVC.m
//  DrawDemo
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "DrawTabBarVC.h"
#import "UITabBarController+OKSliderApp.h"
#import "UIViewController+OKExtension.h"

#define kVCNameKey              @"kVCNameKey"
#define kVCTitleKey             @"kVCTitleKey"
#define kVCNormoImageKey        @"kVCNormoImageKey"
#define kVCSelectedImageKey     @"kVCSelectedImageKey"

@interface DrawTabBarVC ()<UIGestureRecognizerDelegate>

@end

@implementation DrawTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tabBar控制器
    [self initTabBarVC];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //添加边缘侧滑手势控制器
        [self setAppSliderVCWithName:@"DrawAppLeftVC"];
    });
}

/**
 * 初始化tabBar控制器
 */
- (void)initTabBarVC
{
    NSArray *infoArr = @[@{kVCNameKey:@"DrawHomeVC",
                           kVCTitleKey:@"首页",
                           kVCNormoImageKey:@"tab_1",
                           kVCSelectedImageKey:@"tab_1"},
                         
                         @{kVCNameKey:@"DrawHomeVC",
                           kVCTitleKey:@"我的",
                           kVCNormoImageKey:@"tab_2",
                           kVCSelectedImageKey:@"tab_2"},];
    //添加子控制器
    for (NSDictionary *infoDic in infoArr) {
        [self addTabBarChildVCWithName:infoDic[kVCNameKey]
                              navTitle:infoDic[kVCTitleKey]
                            normoImage:[UIImage imageNamed:infoDic[kVCNormoImageKey]]
                         selectedImage:[UIImage imageNamed:infoDic[kVCSelectedImageKey]]];
    }
    
    //设置tabBar选中颜色
    self.tabBar.tintColor = [UIColor orangeColor];
}

/**
 * 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
 */
- (void)addTabBarChildVCWithName:(NSString *)vcName
                        navTitle:(NSString *)navTitle
                      normoImage:(UIImage *)normoImage
                   selectedImage:(UIImage *)selectedImage
{
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    UINavigationController *nav = [[NSClassFromString(@"OKBaseNavigationVC") alloc] initWithRootViewController:vc];
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    vc.navigationItem.title = navTitle;
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:navTitle
                                                  image:normoImage
                                          selectedImage:selectedImage];
    [self addChildViewController:nav];
    
    //添加侧滑按钮
    [vc addLeftBarButtonItem:[UIImage imageNamed:@"tab_3"]
                   highImage:[UIImage imageNamed:@"tab_3"]
                      target:self
                    selector:@selector(showAppSliderView)];
}

/**
 * 显示侧滑
 */
- (void)showAppSliderView
{
    [self showAppSliderView:YES];
}

@end
