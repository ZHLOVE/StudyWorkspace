//
//  UITabBarController+OKSliderApp.m
//  CommonFrameWork
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UITabBarController+OKSliderApp.h"
#import <UIView+OKExtension.h>
#import <OKFrameDefiner.h>
#import <objc/runtime.h>

#define MaxOffsetX                          (self.view.width-49)

static char const * const kLeftMaskView      = "kLeftMaskView";
static char const * const kRightMaskView     = "kRightMaskView";
static char const * const kTabBarMaskView    = "kTabBarMaskView";
static char const * const KHasOpen           = "KHasOpen";

@interface UITabBarController ()<UIGestureRecognizerDelegate>
/** 左侧蒙版 */
@property (nonatomic, strong) UIView *leftMaskView;
/** 右侧蒙版 */
@property (nonatomic, strong) UIView *rightMaskView;
/** tabBar蒙版 */
@property (nonatomic, strong) UIView *tabBarMaskView;
/** 是否已经打开侧滑 */
@property (nonatomic, assign) BOOL hasOpen;
@end

@implementation UITabBarController (OKSliderApp)


#pragma mark - ========== 左侧蒙版 ==========

- (void)setLeftMaskView:(UIView *)leftMaskView
{
    objc_setAssociatedObject(self, kLeftMaskView, leftMaskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)leftMaskView
{
    return objc_getAssociatedObject(self, kLeftMaskView);
}

#pragma mark - ========== 右侧蒙版 ==========

- (void)setRightMaskView:(UIView *)rightMaskView
{
    objc_setAssociatedObject(self, kRightMaskView, rightMaskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)rightMaskView
{
    return objc_getAssociatedObject(self, kRightMaskView);
}

#pragma mark - ========== tabBar蒙版 ==========

- (void)setTabBarMaskView:(UIView *)tabBarMaskView
{
    objc_setAssociatedObject(self, kTabBarMaskView, tabBarMaskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)tabBarMaskView
{
    return objc_getAssociatedObject(self, kTabBarMaskView);
}

#pragma mark - ========== 是否已经打开侧滑 ==========

- (void)setHasOpen:(BOOL)hasOpen
{
    objc_setAssociatedObject(self, KHasOpen, @(hasOpen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hasOpen
{
    id value = objc_getAssociatedObject(self, KHasOpen);
    return [value boolValue];
}


#pragma mark -========== 处理侧滑逻辑 ==========

/**
 * 初始化左侧侧滑视图
 */
- (void)setAppSliderVCWithName:(NSString *)VCName
{
    UIViewController *leftVC = [[NSClassFromString(VCName) alloc] init];
    if (!VCName ||
        ![VCName isKindOfClass:[NSString class]] ||
        !leftVC)
    {
        return;
    }
    
    //左侧蒙层
    [self setLeftVCAndleftMaskView:VCName];
    
    //右侧蒙层
    [self setRightAndTabBarMaskView];
    
    //添加边缘侧滑手势控制器
    [self addScreenPan];
}

/**
 *  左侧蒙层和侧滑控制器
 */
- (void)setLeftVCAndleftMaskView:(NSString *)VCName
{
    UIViewController *leftVC = [[NSClassFromString(VCName) alloc] init];
    leftVC.edgesForExtendedLayout = UIRectEdgeNone;
    leftVC.view.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    [self.view.window insertSubview:leftVC.view atIndex:0];
    [self addChildViewController:leftVC];
    
    self.leftMaskView = [[UIView alloc] init];
    self.leftMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    self.leftMaskView.backgroundColor = [UIColor blackColor];
    self.leftMaskView.alpha = 0.5;
    [leftVC.view insertSubview:self.leftMaskView atIndex:1];
}

/**
 *  右侧蒙层
 */
- (void)setRightAndTabBarMaskView
{
    //1. 设置右侧蒙层添加点击手势
    self.rightMaskView = [[UIView alloc] init];
    self.rightMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    self.rightMaskView.backgroundColor = [UIColor blackColor];
    self.rightMaskView.alpha = 0.0;
    [self.view insertSubview:self.rightMaskView atIndex:1];
    
    UIControl *control = [[UIControl alloc] initWithFrame:self.rightMaskView.frame];
    [control addTarget:self action:@selector(handeTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightMaskView addSubview:control];
    
    
    //2. 设置tabBar蒙层添加点击手势
    self.tabBarMaskView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    self.tabBarMaskView.backgroundColor = [UIColor blackColor];
    self.tabBarMaskView.alpha = 0.0;
    [self.tabBar addSubview:self.tabBarMaskView];
    
    UIControl *control2 = [[UIControl alloc] initWithFrame:self.tabBarMaskView.frame];
    [control2 addTarget:self action:@selector(handeTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarMaskView addSubview:control2];
}

/**
 *  右侧蒙层单击手势
 */
-(void)handeTap:(id)sender
{
    if ((self.view.x == MaxOffsetX)) {
        //点击关闭侧滑
        [self showAppSliderView:NO];
    }
}

#pragma Mark - 初始化侧滑手势

/**
 * 添加边缘侧滑手势控制器
 * 屏幕边缘侧滑: UIScreenEdgePanGestureRecognizer
 * 屏幕全屏滑动: UIPanGestureRecognizer
 */
- (void)addScreenPan
{
    //右侧边缘滑动手势
    UIScreenEdgePanGestureRecognizer *leftScreenPan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(mainSlideHandlePan:)];
    leftScreenPan.edges = UIRectEdgeLeft;
    leftScreenPan.delegate = self;
    [leftScreenPan setCancelsTouchesInView:YES];
    [self.view addGestureRecognizer:leftScreenPan];
    
    //右侧蒙版全屏滑动手势
    UIPanGestureRecognizer *rightMaskPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainSlideHandlePan:)];
    rightMaskPan.delegate = self;
    [rightMaskPan setCancelsTouchesInView:YES];
    [self.rightMaskView addGestureRecognizer:rightMaskPan];
    
    //设置tabBar蒙层全屏滑动手势
    UIPanGestureRecognizer *tabBarMaskPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainSlideHandlePan:)];
    tabBarMaskPan.delegate = self;
    [tabBarMaskPan setCancelsTouchesInView:YES];
    [self.tabBarMaskView addGestureRecognizer:tabBarMaskPan];
    
}

#pragma mark -滑动手势

//滑动手势
- (void)mainSlideHandlePan:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self.view];
    
    if (self.hasOpen) {
        CGFloat percent = -point.x/(MaxOffsetX);
        self.view.x = MAX(MaxOffsetX + point.x, 0);
        self.leftMaskView.alpha = percent * 0.5;
        self.rightMaskView.alpha = 0.3 * (1-percent);
        self.tabBarMaskView.alpha = self.rightMaskView.alpha;
        
        //手势结束后修正位置,超过约一半时向多出的一半偏移
        if (gesture.state == UIGestureRecognizerStateEnded) {
            [self showAppSliderView:(self.view.x > MaxOffsetX*0.85)];
        }
        
    } else {
        //屏幕宽度一半的百分比
        CGFloat percent = point.x/(self.view.width/2);
        self.view.x = MIN((MAX(point.x, 0)), MaxOffsetX);;
        self.leftMaskView.alpha = 0.5 * (1-percent);
        self.rightMaskView.alpha = 0.3 * (percent-1);
        self.tabBarMaskView.alpha = self.rightMaskView.alpha;
        
        //手势结束后修正位置,超过约一半时向多出的一半偏移
        if (gesture.state == UIGestureRecognizerStateEnded) {
            [self showAppSliderView:(self.view.x > self.view.width/4)];
        }
    }
}

/**
 * 是否关闭侧滑视图
 */
- (void)showAppSliderView:(BOOL)open
{
    [UIView animateWithDuration:0.3 animations:^{
        if (open) { //打开侧滑
            self.view.x = MaxOffsetX;
            self.leftMaskView.alpha = 0.0;
            self.rightMaskView.alpha = 0.3;
            self.tabBarMaskView.alpha = self.rightMaskView.alpha;
            
        } else { //关闭侧滑
            self.view.x = 0;
            self.leftMaskView.alpha = 0.5;
            self.rightMaskView.alpha = 0.0;
            self.tabBarMaskView.alpha = self.rightMaskView.alpha;
        }
    } completion:^(BOOL finished) {
        self.hasOpen = open;
    }];
}

@end
