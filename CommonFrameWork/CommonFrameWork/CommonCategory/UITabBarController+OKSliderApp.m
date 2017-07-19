//
//  UITabBarController+OKSliderApp.m
//  CommonFrameWork
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UITabBarController+OKSliderApp.h"
#import <objc/runtime.h>

//左侧控制器的起始位置
#define kLeftVCStartX            (-80)
//左侧控制器最大的便宜位置
#define MaxOffsetX               (self.view.frame.size.width-80)
//获取屏幕宽度
#ifndef Screen_Width
#define Screen_Width             ([UIScreen  mainScreen].bounds.size.width)
#endif
//获取屏幕高度
#ifndef Screen_Height
#define Screen_Height            ([UIScreen mainScreen].bounds.size.height)
#endif

static char const * const kLeftMaskView      = "kLeftMaskView";
static char const * const kRightMaskView     = "kRightMaskView";
static char const * const kTabBarMaskView    = "kTabBarMaskView";
static char const * const kLeftViewController = "kLeftViewController";
static char const * const KHasOpen           = "KHasOpen";

@interface UITabBarController ()<UIGestureRecognizerDelegate>
/** 左侧蒙版 */
@property (nonatomic, strong) UIView *leftMaskView;
/** 右侧蒙版 */
@property (nonatomic, strong) UIView *rightMaskView;
/** tabBar蒙版 */
@property (nonatomic, strong) UIView *tabBarMaskView;
/** 左侧控制器 */
@property (nonatomic, strong) UIViewController *leftVC;
/** 是否已经打开侧滑 */
@property (nonatomic, assign) BOOL hasOpen;
@end

@implementation UITabBarController (OKSliderApp)


#pragma mark - ========== 左侧控制器 ==========

- (void)setLeftVC:(UIViewController *)leftVC
{
    objc_setAssociatedObject(self, kLeftViewController, leftVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)leftVC
{
    return objc_getAssociatedObject(self, kLeftViewController);
}

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
- (BOOL)initAppSliderVCWithName:(NSString *)vcName
{
    UIViewController *leftVC = [[NSClassFromString(vcName) alloc] init];
    if (!vcName ||
        ![vcName isKindOfClass:[NSString class]] ||
        !leftVC)
    {
        NSLog(@"初始化左侧侧滑视图失败, 没有对应名称的控制器: %@",vcName);
        return NO;
    }
    
    if (self.rightMaskView) {
        NSLog(@"请勿重复初始化: %@",vcName);
        return NO;
    }
    
    //左侧蒙层
    [self setLeftVCAndleftMaskView:vcName];
    
    //右侧蒙层
    [self setRightAndTabBarMaskView];
    
    //添加边缘侧滑手势控制器
    [self addScreenPan];
    
    return YES;
}

/**
 *  左侧蒙层和侧滑控制器
 */
- (void)setLeftVCAndleftMaskView:(NSString *)vcName
{
    UIViewController *leftVC = [[NSClassFromString(vcName) alloc] init];
    leftVC.edgesForExtendedLayout = UIRectEdgeNone;
    leftVC.view.frame = CGRectMake(kLeftVCStartX, 0, Screen_Width, Screen_Height);
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window insertSubview:leftVC.view atIndex:0];
    [self addChildViewController:leftVC];
    self.leftVC = leftVC;
    
    self.leftMaskView = [[UIView alloc] init];
    self.leftMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    self.leftMaskView.backgroundColor = [UIColor blackColor];
    self.leftMaskView.alpha = 0.0;
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
    if ((self.view.frame.origin.x == MaxOffsetX)) {
        //点击关闭侧滑
        [self showAppSliderView:@(NO)];
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
    //左侧边缘滑动手势
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
    
    //手势结束后超过这个值则修正位置
    CGFloat convertX = 0.0;
    CGRect selfRect = self.view.frame;
    CGRect leftRect = self.leftVC.view.frame;
    
    if (self.hasOpen) { //将要关闭左侧视图
        
        //1.控制当前App视图位置
        selfRect.origin.x = MIN(MAX(MaxOffsetX + point.x, 0), MaxOffsetX);
        
        //2.控制当前左侧视图位置
        leftRect.origin.x = MAX((selfRect.origin.x*0.27+kLeftVCStartX), kLeftVCStartX);
        
        //3.手势结束后，修正位置来关闭左侧视图
        convertX = MaxOffsetX*0.85;
        
    } else {//将要打开左侧视图
        //1.控制当前App视图位置
        selfRect.origin.x = MIN((MAX(point.x, 0)), MaxOffsetX);
        
        //2.控制当前左侧视图位置
        leftRect.origin.x = MIN((kLeftVCStartX + selfRect.origin.x*0.3), 0);
        
        //3.手势结束后，修正位置来打开左侧视图
        convertX = self.view.frame.size.width/4;
    }
    
    self.leftVC.view.frame = leftRect;
    self.view.frame = selfRect;
    
    //控制两边蒙层的透明度
    CGFloat percent = selfRect.origin.x/(MaxOffsetX);
    self.leftMaskView.alpha = 0.5-percent*0.5;
    self.rightMaskView.alpha = percent*0.3;
    self.tabBarMaskView.alpha = self.rightMaskView.alpha;
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        BOOL open = (self.view.frame.origin.x > convertX);
        [self showAppSliderView:@(open)];
    }
}

/**
 是否关闭侧滑视图
 
 @param openFlag @1：打开，@2关闭
 */
- (void)showAppSliderView:(NSNumber *)openFlag
{
    if (!self.rightMaskView) return;
    
    BOOL open = [openFlag boolValue];
    
    __block CGRect selfRect = self.view.frame;
    __block CGRect leftRect = self.leftVC.view.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (open) { //打开侧滑
            selfRect.origin.x = MaxOffsetX;
            leftRect.origin.x = 0;
            
            self.leftMaskView.alpha = 0.0;
            self.rightMaskView.alpha = 0.3;
            
        } else { //关闭侧滑
            selfRect.origin.x = 0;
            leftRect.origin.x = kLeftVCStartX;
            
            self.leftMaskView.alpha = 0.5;
            self.rightMaskView.alpha = 0.0;
        }
        
        self.view.frame = selfRect;
        self.leftVC.view.frame = leftRect;
        self.tabBarMaskView.alpha = self.rightMaskView.alpha;
        
    } completion:^(BOOL finished) {
        self.hasOpen = open;
    }];
}

@end
