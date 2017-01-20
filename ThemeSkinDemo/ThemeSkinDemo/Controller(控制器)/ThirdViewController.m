//
//  ThirdViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ThirdViewController ()
@property (nonatomic, strong) FourthViewController *fourthVC;
@property (nonatomic, strong) UIView *bgNavView;
@property (nonatomic, strong) UIColor *lastNavBgColor;
@end

@implementation ThirdViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.lastNavBgColor = self.navigationController.okNavBackgroundColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);    
    self.navigationController.okNavBackgroundColor = self.lastNavBgColor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //初始化UI
    [self fourthVC];
    
    //请求所有数据
    [self requestAllData];
}

/**
 * 监听重复点击tabBar按钮事件
 */
- (void)repeatTouchTabBarToViewController:(UIViewController *)touchVC
{
    [self.fourthVC scrollToTop];
}

#pragma Mark - 初始化UI

/**
 *  初始化子控制器，当做视图使用
 */
- (FourthViewController *)fourthVC
{
    if (!_fourthVC) {
        _fourthVC = [[FourthViewController alloc] init];
        _fourthVC.edgesForExtendedLayout = UIRectEdgeNone;
        [self.view addSubview:_fourthVC.view];
        [self addChildViewController:_fourthVC];
    }
    return _fourthVC;
}

#pragma Mark - 请求所有数据

/**
 * 处理数据请求回调
 */
- (void)requestAllData
{
    WEAKSELF
    //处理请求1回调
    [self requestData1:^(id returnValue) {
        [weakSelf.fourthVC refreshUI1WithData:returnValue];
    }];
    
    //处理请求2回调
    [self requestData2:^(id returnValue) {
        [weakSelf.fourthVC refreshUI2WithData:returnValue];
    }];
    
    //处理请求3回调
    [self requestData3:^(id returnValue) {
        [weakSelf.fourthVC refreshUI3WithData:returnValue];
    }];
}

/**
 * 请求数据1
 */
- (void)requestData1:(void(^)(id returnValue))block
{
    [OKHttpRequestTools sendOKRequest:nil success:^(id returnValue) {
        if (block) {
            block(returnValue);
        }
    } failure:^(NSError *error) {
        ShowAlertToast(error.domain);
    }];
}

/**
 * 请求数据2
 */
- (void)requestData2:(void(^)(id returnValue))block
{
    [OKHttpRequestTools sendOKRequest:nil success:^(id returnValue) {
        if (block) {
            block(returnValue);
        }
    } failure:^(NSError *error) {
        ShowAlertToast(error.domain);
    }];
}

/**
 * 请求数据3
 */
- (void)requestData3:(void(^)(id returnValue))block
{
    [OKHttpRequestTools sendOKRequest:nil success:^(id returnValue) {
        if (block) {
            block(returnValue);
        }
    } failure:^(NSError *error) {
        ShowAlertToast(error.domain);
    }];
}

- (void)changeNavBgColor:(CGFloat)percent
{
    self.navigationController.okNavBackgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:percent];
}

@end
