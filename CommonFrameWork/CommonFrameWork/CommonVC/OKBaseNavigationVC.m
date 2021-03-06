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
    //设配iOS11, 
    if (@available(iOS 11.0, *)) {
        //警告：webview中的ScrollView使用appearance设置无效，需要单独设置
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

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
 *  注意：在返回时不能移除通知，因为有个bug，有时即使走了popViewControllerAnimated等方法也没有返回上衣页面
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    //[self viewAnimation];
    //[[NSNotificationCenter defaultCenter] removeObserver:vc];
    
    UIViewController *vc = [super popViewControllerAnimated:animated];
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
    return vcArr;
}

/**
 *  返回时移除所有通知
 */
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray *vcArr = [super popToRootViewControllerAnimated:animated];
    return vcArr;
}

@end
