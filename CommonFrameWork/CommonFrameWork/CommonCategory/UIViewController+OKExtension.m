//
//  UIViewController+OKExtension.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UIViewController+OKExtension.h"
#import "UIBarButtonItem+OKExtension.h"
#import "OKColorDefiner.h"
#import "UIView+OKTool.h"

@implementation UIViewController (OKExtension)

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(NSString *)title target:(id)target selector:(SEL)selector
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithTitle:title titleColor:Color_BlackFont target:target selector:selector];
}

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(UIImage *)normolImage highImage:(UIImage *)highImage target:(id)target selector:(SEL)selector
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:normolImage highImage:highImage target:target action:selector];
}

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(UIImage *)normolImage highImage:(UIImage *)highImage target:(id)target selector:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:normolImage highImage:highImage target:target action:selector];
}

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(NSString *)title target:(id)target selector:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:title titleColor:Color_BlackFont target:target selector:selector];
}

/**
 *  设置导航按右侧钮点击状态
 */
- (void)setRightBarItemEnable:(BOOL)enable
{
    for (UIBarButtonItem *barItem in self.navigationItem.rightBarButtonItems) {
        if (barItem.customView && [barItem.customView isKindOfClass:[UIButton class]]) {
            UIButton *rightBtn = (UIButton *)barItem.customView;
            rightBtn.enabled = enable;
            UIColor *titleColor = self.navigationController.viewControllers.count>1 ? Color_BlackFont : Color_BlackFont;
            [rightBtn setTitleColor:enable ? titleColor : [titleColor colorWithAlphaComponent:0.4]  forState:UIControlStateNormal];
        } else {
            barItem.enabled = enable;
        }
    }
}

/**
 *  返回到指定控制器
 */
- (BOOL)shouldPopToCustomVC:(NSString *)classStr
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(classStr)]) {
            [self.navigationController popToViewController:vc animated:YES];
            return YES;
        }
    }
    return NO;
}

/**
 *  进入到指定控制器
 */
- (void)pushToCustomVC:(NSString *)classStr title:(NSString *)title
{
    UIViewController *VC = [NSClassFromString(classStr) new];
    if ([VC isKindOfClass:[UIViewController class]]) {
        VC.title = title;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

/**
 *  此导航条仅供上一个页面没有导航栏, 下一个页面滑动边缘返回时会顶部异常的情况,
 *  添加一个假的导航view
 *  备注：如果要隐藏导航栏，不能用 setNavigationBarHidden 影藏导航, 
 *  否则在滑动返回一点点后再push时导航会出现覆盖异常
 *  只能用这种方式：self.navigationController.navigationBar.hidden = YES;
 */
- (void)showFakeNavBarWhenScreenEdgePanBack
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, self.view.bounds.size.width, 64)];
    
    //对导航栏截图
    UIView *fakeNavBarView = [self.navigationController.navigationBar snapshotViewAfterScreenUpdates:NO];
    CGRect rect = fakeNavBarView.frame;
    rect.origin.y = 20;
    fakeNavBarView.frame = rect;
    fakeNavBarView.backgroundColor = [UIColor whiteColor];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:fakeNavBarView];
    
    //添加底部细线
    [bgView addLineToPosition:OkDrawLine_bottom lineWidth:1];
    [self.view insertSubview:bgView atIndex:0];
}


#pragma mark - /*** 顶层控制器 ***/
/**
 *  获取最顶层的控制器
 */
+ (UIViewController *)currentTopViewController{
    UIViewController *viewController = [self activityViewController];
    UIViewController *lastViewController  = [self getCurrentViewController:viewController];
    return lastViewController;
}

/**
 *  获取最顶层的控制器
 */
+ (UIViewController *)getCurrentViewController:(UIViewController *)viewController
{
    UIViewController *lastViewController  = nil;
    
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController *)viewController ;
        NSInteger selectIndex = tabBarController.selectedIndex ;
        if (selectIndex < tabBarController.viewControllers.count) {
            UIViewController *tabViewController = tabBarController.viewControllers[selectIndex];
            if ([tabViewController isKindOfClass:[UINavigationController class]]) {
                lastViewController = [[(UINavigationController *)tabViewController viewControllers] lastObject];
                lastViewController = [self getPresentedViewController :lastViewController];
            }else{
                lastViewController = [self getPresentedViewController:tabViewController];
            }
        }
    }else if ([viewController isKindOfClass:[UINavigationController class]]){
        
        lastViewController = [[(UINavigationController *)viewController viewControllers] lastObject];
        lastViewController = [self getPresentedViewController:lastViewController];
    }else{
        
        lastViewController = [self getPresentedViewController:viewController];
    }
    
    return lastViewController;
}
/**
 *  获取PresentedViewController
 */
+ (UIViewController *)getPresentedViewController:(UIViewController *)viewController
{
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;                // 1. ViewController 下
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {                // 2. NavigationController 下
            viewController =  [self getCurrentViewController:viewController];
        }
        
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            viewController = [self getCurrentViewController:viewController];     // 3. UITabBarController 下
        }
    }
    return viewController;
}
/**
 *  获取当前处于activity状态的view controller
 */
+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

@end
