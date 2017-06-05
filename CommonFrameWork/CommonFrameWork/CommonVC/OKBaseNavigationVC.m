//
//  OKBaseNavigationVC.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKBaseNavigationVC.h"
#import "OKColorDefiner.h"
#import "OKPubilcKeyDefiner.h"
#import "UIViewController+OKExtension.h"
#import "OKAlertView.h"
#import "OKCFunction.h"

@interface OKBaseNavigationVC ()

@end

@implementation OKBaseNavigationVC

+ (void)initialize
{
    // 设置导航栏标题文字
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = FontSystemSize(18);
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTitleTextAttributes:dict];
    
    // 导航栏Item文字
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    itemDict[NSFontAttributeName] = FontThinCustomSize(16);
    itemDict[NSForegroundColorAttributeName] = Color_BlackFont;
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];

    //将返回按钮的文字position设置不在屏幕上显示
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置返回按钮
    if ( self.viewControllers.count > 0) {
        UIImage *backImage = [UIImage imageNamed:@"commonImage.bundle/backBarButtonItemImage" inBundle:[NSBundle bundleForClass:NSClassFromString(@"OKBaseNavigationVC")] compatibleWithTraitCollection:nil];
        
        SEL selector = NSSelectorFromString(@"backBtnClick:");
        
        if ([viewController respondsToSelector:selector]) {
            [viewController addLeftBarButtonItem:backImage
                                       highImage:nil
                                          target:viewController
                                        selector:selector];
        } else {
            [viewController addLeftBarButtonItem:backImage
                                       highImage:nil
                                          target:self
                                        selector:@selector(popViewControllerAnimated:)];
        }
        
        //push进去的控制器隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        //设置self.view的起始位置为顶部
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回时移除所有通知
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    //[self viewAnimation];
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:vc];
    return vc;
}

/**
 *  自定义过度动画
 */
- (void)viewAnimation
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionMoveIn;
    [self.view.layer addAnimation:transition forKey:nil];
}

/**
 *  返回时移除所有通知
 */
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *vcArr = [super popToViewController:viewController animated:animated];
    for (UIViewController *vc in vcArr) {
        [[NSNotificationCenter defaultCenter] removeObserver:vc];
    }
    return vcArr;
}

/**
 *  返回时移除所有通知
 */
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray *vcArr = [super popToRootViewControllerAnimated:animated];
    for (UIViewController *vc in vcArr) {
        [[NSNotificationCenter defaultCenter] removeObserver:vc];
    }
    return vcArr;
}

@end
