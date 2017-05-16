//
//  SlideAppTabBarVC.m
//  SlideApp
//
//  Created by mao wangxin on 2017/2/9.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "SlideAppTabBarVC.h"
#import <UIView+OKExtension.h>
#import "AppTabBarVC1.h"
#import "AppTabBarVC2.h"
#import "AppTabBarVC3.h"

//获取屏幕宽度
#define Screen_Width            ([UIScreen  mainScreen].bounds.size.width)
//获取屏幕高度
#define Screen_Height           ([UIScreen mainScreen].bounds.size.height)

#define MaxOffsetX      (self.view.width-49)

@interface SlideAppTabBarVC ()<UIGestureRecognizerDelegate>


/** 单击右侧蒙板事件 */
@property (nonatomic, strong) UIControl *tapMaskControl;
/** TabBar起始Y */
@property (nonatomic, assign) CGFloat startTabBarY;
/** 左侧蒙版 */
@property (nonatomic, strong) UIView *leftMaskView;
/** 右侧蒙版 */
@property (nonatomic, strong) UIView *rightMaskView;
/** 夜间模式view */
@property (nonatomic, strong) UIView *nightsMaskView;
/** 是否已经打开侧滑 */
@property (nonatomic, assign) BOOL hasOpen;
@end

@implementation SlideAppTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化tabBar控制器
    [self initTabBarVCS];
    
    //添加边缘侧滑手势控制器
    [self addScreenPan];
}

#pragma mark - 初始化AppTabBar

- (void)initTabBarVCS
{
    AppTabBarVC1 *firstVC = [[AppTabBarVC1 alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    firstVC.tabBarItem = [self createTabBarItemWithTitle:@"微信" imageName:@"icon_home1" selectedImage:@"icon_home2"];
    firstVC.title = @"微信";
    firstVC.edgesForExtendedLayout = UIRectEdgeNone;
    
    firstVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开关" style:UIBarButtonItemStylePlain target:self action:@selector(converLeftViewAction:)];
    firstVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"夜间模式" style:UIBarButtonItemStylePlain target:self action:@selector(showAppMaskView:)];
    

    AppTabBarVC2 *secondVc = [[AppTabBarVC2 alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVc];
    secondVc.tabBarItem = [self createTabBarItemWithTitle:@"微博" imageName:@"tabbar_shop_nor" selectedImage:@"tabbar_shop_ser"];
    secondVc.title = @"微博";
    secondVc.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    AppTabBarVC3 *mineVC = [[AppTabBarVC3 alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem = [self createTabBarItemWithTitle:@"QQ" imageName:@"tabbar_cashier_nor" selectedImage:@"tabbar_cashier_ser"];
    mineVC.title = @"收银";
    mineVC.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setViewControllers:@[firstNav, secondNav, mineNav] animated:NO];
}

/**
 * 创建UITabBarItem
 */
- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title
                                  imageName:(NSString *)imageName
                              selectedImage:(NSString *)selectedImageName
{
    UIImage *norImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *serImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:norImage selectedImage:serImage];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor brownColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return item;
}

#pragma mark - 添加App侧滑事件

- (UIView *)leftMaskView
{
    if (!_leftMaskView) {
        _leftMaskView = [[UIView alloc] init];
        _leftMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        _leftMaskView.backgroundColor = [UIColor blackColor];
        _leftMaskView.alpha = 0.5;
        [self.parentViewController.view insertSubview:_leftMaskView atIndex:1];
    }
    return _leftMaskView;
}

- (UIView *)rightMaskView
{
    if (!_rightMaskView) {
        _rightMaskView = [[UIView alloc] init];
        _rightMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        _rightMaskView.backgroundColor = [UIColor blackColor];
        _rightMaskView.alpha = 0.0;
        [self.view addSubview:_rightMaskView];
//        [self.view bringSubviewToFront:_rightMaskView];
    }
    return _rightMaskView;
}

/**
 * 是否打开左侧视图
 */
- (void)converLeftViewAction:(UIButton *)button
{
    [self showLeftView:(self.view.x != MaxOffsetX)];
}

/**
 * 是否关闭左侧视图
 */
- (void)showLeftView:(BOOL)open
{
    [UIView animateWithDuration:0.3 animations:^{
        if (open) { //打开侧滑
            self.view.x = MaxOffsetX;
            self.leftMaskView.alpha = 0.0;
            self.rightMaskView.alpha = 0.3;
            
            [self addTapAction:YES];
            
        } else { //关闭侧滑
            self.view.x = 0;
            self.leftMaskView.alpha = 0.5;
            self.rightMaskView.alpha = 0.0;
            
            [self addTapAction:NO];
        }
    } completion:^(BOOL finished) {
        self.hasOpen = open;
    }];
}

/**
 * 打开侧滑之后添加单击手势
 */
- (void)addTapAction:(BOOL)addTapGes
{
    if (addTapGes) {
        //点击打开的右侧蒙板
        UIControl *control = [[UIControl alloc] initWithFrame:self.rightMaskView.frame];
        [control addTarget:self action:@selector(handeTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightMaskView addSubview:control];
        self.tapMaskControl = control;
        
    } else {
        [self.tapMaskControl removeTarget:self action:@selector(handeTap:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 单击手势
-(void)handeTap:(id)sender
{
    if ((self.view.x == MaxOffsetX)) {
        //点击关闭侧滑
        [self showLeftView:NO];
    }
}

/**
 * 添加边缘侧滑手势控制器
 */
- (void)addScreenPan
{
    //UIScreenEdgePanGestureRecognizer , UIPanGestureRecognizer
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
    
    //添加右侧边缘投影效果，有蒙版可不加投影
    [self.view.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.view.layer setShadowRadius:5];
    [self.view.layer setShadowOpacity:1];
    [self.view.layer setShadowColor:[UIColor colorWithWhite:0 alpha:0.48].CGColor];
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, Screen_Height)].CGPath;
}

#pragma mark - 滑动手势

//滑动手势
- (void)mainSlideHandlePan:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self.view];
    
    if (self.hasOpen) {
        CGFloat percent = -point.x/(MaxOffsetX);
        self.view.x = MAX(MaxOffsetX + point.x, 0);
        
        self.leftMaskView.alpha = percent * 0.5;
        self.rightMaskView.alpha = 0.3 * (1-percent);
        
        //手势结束后修正位置,超过约一半时向多出的一半偏移
        if (gesture.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.3 animations:^{
                [self showLeftView:(self.view.x > MaxOffsetX*0.85)];
            }];
        }
        
    } else {
        //屏幕宽度一半的百分比
        CGFloat percent = point.x/(self.view.width/2);
        self.view.x = MIN((MAX(point.x, 0)), MaxOffsetX);;
        
        self.leftMaskView.alpha = 0.5 * (1-percent);
        self.rightMaskView.alpha = 0.3 * (percent-1);
        
        //手势结束后修正位置,超过约一半时向多出的一半偏移
        if (gesture.state == UIGestureRecognizerStateEnded) {
            
            [UIView animateWithDuration:0.3 animations:^{
                [self showLeftView:(self.view.x > self.view.width/4)];
            }];
        }
    }
}


/**
 * 夜间模式
 */
- (void)showAppMaskView:(id)sender
{
    self.nightsMaskView.hidden = !self.nightsMaskView.hidden;
}

- (UIView *)nightsMaskView
{
    if (!_nightsMaskView) {
        _nightsMaskView = [[UIView alloc] init];
        _nightsMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        _nightsMaskView.backgroundColor = [UIColor blackColor];
        _nightsMaskView.alpha = 0.5;
        _nightsMaskView.userInteractionEnabled = NO;
        [self.view.window addSubview:_nightsMaskView];
        [self.view.window bringSubviewToFront:_nightsMaskView];
    }
    return _nightsMaskView;
}

@end
