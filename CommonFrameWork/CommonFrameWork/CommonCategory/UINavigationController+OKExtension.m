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
    if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectFilterView")]) {
        objc_setAssociatedObject(self, kNavBarKey, superView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        superView.backgroundColor = color;
        return;
    }
    
    for (UIView *view in superView.subviews) {
        [self setOKNavBgColor:view color:color];
    }
}

@end
