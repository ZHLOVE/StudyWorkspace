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
#import "OKPubilcKeyDefiner.h"

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
 *  设置导航按右侧钮点击状态
 */
- (void)setNavRightBarItemEnable:(BOOL)enable titleColor:(UIColor *)color
{
    for (UIBarButtonItem *barItem in self.navigationItem.rightBarButtonItems) {
        if (barItem.customView && [barItem.customView isKindOfClass:[UIButton class]]) {
            UIButton *rightBtn = (UIButton *)barItem.customView;
            rightBtn.enabled = enable;
            [rightBtn setTitleColor:color forState:UIControlStateNormal];
        } else {
            barItem.enabled = enable;
        }
    }
}


/**
 * 使用系统的返回按钮样式，
 * 注意：如果想要获取系统返回按钮的点击事件，
 * 可以打开《UINavigationController+OKExtension.m》类中的<navigationBar:shouldPopItem:>方法，
 * 在要操作的控制器中实现<navigationShouldPopOnBackButton>返回一个BOOL值来控制
 */
- (void)shouldUseSystemBackBtnStyle
{
    //此方法一定要在控制器的<viewDidLoad>和<viewDidAppear>中调用，否则无效
    
    //设置返回按钮图片
    UIImage *backImage = [UIImage imageNamed:@"commonImage.bundle/backBarButtonItemImage"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage;
    self.navigationController.navigationBar.backIndicatorImage = backImage;
    
    //置空返回按钮标题
    self.navigationController.navigationBar.backItem.title = @"";
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



/**
 *  判断在导航栏控制器中有没存在该类
 *
 *  @param className 类名
 *
 *  @return 返回存在的控制器  没有存在则为nil
 */
- (UIViewController *)isExistClassInSelfNavigation:(NSString *)className
{
    UIViewController *existVC = nil;
    if (className.length>0) {
        for (UIViewController *tempVC in self.navigationController.viewControllers) {
            if ([tempVC isKindOfClass:NSClassFromString(className)]) {
                existVC = tempVC;
                break;
            }
        }
    }
    return existVC;
}

#pragma mark -===========携带参数页面跳转===========

/**
 带参数跳转到目标控制器, 如果导航栈中存在目标器则pop, 不存在则push
 
 @param vcName 目标控制器
 @param propertyDic 目标控制器属性字典
 @param selectorStr 跳转完成后需要执行的方法
 */
- (void)pushOrPopToViewController:(NSString *)vcName
                        aSelector:(NSString *)selectorStr
                       withObject:(NSDictionary *)propertyDic
{
    if (propertyDic && ![propertyDic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"❌❌❌ 页面push失败，携带属性字典错误:%@",propertyDic);
        return;
    }
    UIViewController *tempVC = [[NSClassFromString(vcName) alloc] init];
    
    if ([tempVC isKindOfClass:[UIViewController class]]) {
        
        UIViewController *popTargetVC = [self isExistClassInSelfNavigation:vcName];
        if (popTargetVC) {
            //KVC赋值控制器的属性
            if (propertyDic && [propertyDic isKindOfClass:[NSDictionary class]]) {
                [popTargetVC setValuesForKeysWithDictionary:propertyDic];
            }
            
            if ([self isKindOfClass:[UINavigationController class]]) {
                [(UINavigationController *)self popToViewController:popTargetVC animated:YES];
            } else {
                [self.navigationController popToViewController:popTargetVC animated:YES];
            }
            
            //判断在pop完成后是否需要调用相关方法
            SEL selector = NSSelectorFromString(selectorStr);
            if (selectorStr.length>0 && [popTargetVC respondsToSelector:selector]) {
                OKPerformSelectorLeakWarning(
                                             [popTargetVC performSelector:selector withObject:nil];
                                             );
            }
        } else {
            //KVC赋值控制器的属性
            if (propertyDic && [propertyDic isKindOfClass:[NSDictionary class]]) {
                [tempVC setValuesForKeysWithDictionary:propertyDic];
            }
            
            if ([self isKindOfClass:[UINavigationController class]]) {
                [(UINavigationController *)self pushViewController:tempVC animated:YES];
            } else {
                [self.navigationController pushViewController:tempVC animated:YES];
            }
        }
    } else {
        NSLog(@"❌❌❌ 页面push失败，名称对应的控制器不存在: %@",vcName);
    }
}


/**
 *  执行push页面跳转
 *
 *  @param vcName 当前的控制器
 *  @param propertyDic 控制器需要的参数
 */
- (void)pushToViewController:(NSString *)vcName propertyDic:(NSDictionary *)propertyDic
{
    if (propertyDic && ![propertyDic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"❌❌❌ 页面push失败，携带属性字典错误:%@",propertyDic);
        return;
    }
    UIViewController *pushVC = [[NSClassFromString(vcName) alloc] init];
    if ([pushVC isKindOfClass:[UIViewController class]]) {
        if (propertyDic && [propertyDic isKindOfClass:[NSDictionary class]]) {
            [pushVC setValuesForKeysWithDictionary:propertyDic];
        }
        
        if ([self isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)self pushViewController:pushVC animated:YES];
        } else {
            [self.navigationController pushViewController:pushVC animated:YES];
        }
    } else {
        NSLog(@"❌❌❌ 页面push失败，名称对应的控制器不存在: %@",vcName);
    }
}

/**
 *  执行页面present跳转
 *
 *  @param vcName 当前的控制器
 *  @param propertyDic 控制器需要的参数
 */
- (void)presentToViewController:(NSString *)vcName
                     withObject:(NSDictionary *)propertyDic
                  showTargetNav:(BOOL)showNavigation
{
    if (propertyDic && ![propertyDic isKindOfClass:[NSDictionary class]]) {
        NSLog(@"❌❌❌ 页面push失败，携带属性字典错误:%@",propertyDic);
        return;
    }
    UIViewController *presentVC = [[NSClassFromString(vcName) alloc] init];
    if ([presentVC isKindOfClass:[UIViewController class]]) {
        if (propertyDic && [propertyDic isKindOfClass:[NSDictionary class]]) {
            [presentVC setValuesForKeysWithDictionary:propertyDic];
        }
        
        if (showNavigation) {
            UINavigationController *presentNav = nil;
            if (self.navigationController) {
                presentNav = [[[self.navigationController class] alloc] initWithRootViewController:presentVC];
            } else {
                presentNav = [[UINavigationController alloc] initWithRootViewController:presentVC];
            }
            [self presentViewController:presentNav animated:YES completion:nil];
        } else {
            [self presentViewController:presentVC animated:YES completion:nil];
        }
    } else {
        NSLog(@"❌❌❌ 页面push失败，名称对应的控制器不存在: %@",vcName);
    }
}

/**
 * 警告：此方法不要删除，在上面的方法(pushController: parm:)的参数携带错误时防止崩溃
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"❌❌❌ 警告:< %@ >: 类没有实现该属性: %@",[self class],key);
}


@end
