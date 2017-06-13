//
//  UINavigationController+OKExtension.m
//  CommonFrameWork
//
//  Created by Luke on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UINavigationController+OKExtension.h"
#import <objc/runtime.h>

static char const * const kNavBarKey  = "kNavBarKey";

@interface UINavigationController ()
@property (nonatomic, strong) UIView *okNavBgView;
@end

@implementation UINavigationController (OKExtension)


#pragma mark -===========改变导航背景色===========

- (void)setOkNavBackgroundColor:(UIColor *)okNavBackgroundColor
{
    if (self.okNavBgView) {
        self.okNavBgView.backgroundColor = okNavBackgroundColor;
    } else {
        [self setOKNavBgColor:self.navigationBar color:okNavBackgroundColor];
    }
}

- (UIColor *)okNavBackgroundColor
{
    return self.okNavBgView.backgroundColor;
}

- (UIView *)okNavBgView
{
    return objc_getAssociatedObject(self, kNavBarKey);
}

/**
 *  设置导航栏背景色
 */
-(void)setOKNavBgColor:(UIView *)superView color:(UIColor *)color
{
    if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectFilterView")] || [superView isKindOfClass:NSClassFromString(@"_UIBackdropEffectView")]) {
        objc_setAssociatedObject(self, kNavBarKey, superView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        superView.backgroundColor = color;
        return;
    }
    
    for (UIView *view in superView.subviews) {
        [self setOKNavBgColor:view color:color];
    }
}

/**
#pragma mark -===========<UINavigationBarDelegate>===========
 
//控制系统返回按钮是否能点击返回
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    SEL sel = @selector(navigationShouldPopOnBackButton);
    //在想要操作的控制器中实现sel方法即可
    if([vc respondsToSelector:sel]) {
        shouldPop = [vc performSelector:sel];//[vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        //注意：这里不能直接 return YES;，否则页面上回出现无法正常返回上一页面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

//使用：在需要操作的控制器中实现该方法，来控制返回按钮是否能点击返回
- (BOOL)navigationShouldPopOnBackButton
{
    return YES;
}
*/

@end
