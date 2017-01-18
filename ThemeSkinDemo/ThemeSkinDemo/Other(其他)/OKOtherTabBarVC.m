//
//  CCTabBar2VC.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKOtherTabBarVC.h"
#import "ThirdViewController.h"

@interface OKOtherTabBarVC ()

@end

@implementation OKOtherTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化tabBar控制器
    [self initTabBarVCS];
}


- (void)initTabBarVCS
{
    ThirdViewController *firstVC = [[ThirdViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    firstVC.tabBarItem = [self createTabBarItemWithTitle:@"微信" imageName:@"icon_home1" selectedImage:@"icon_home2"];
    firstVC.title = @"微信";
    firstVC.navigationItem.leftBarButtonItem = [self addBackBtnItem];
    
    
    
    ThirdViewController *secondVc = [[ThirdViewController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVc];
    secondVc.tabBarItem = [self createTabBarItemWithTitle:@"微博" imageName:@"tabbar_shop_nor" selectedImage:@"tabbar_shop_ser"];
    secondVc.title = @"微博";
    secondVc.navigationItem.leftBarButtonItem = [self addBackBtnItem];
    
    
    
    ThirdViewController *mineVC = [[ThirdViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem = [self createTabBarItemWithTitle:@"QQ" imageName:@"tabbar_cashier_nor" selectedImage:@"tabbar_cashier_ser"];
    mineVC.title = @"QQ";
    mineVC.navigationItem.leftBarButtonItem = [self addBackBtnItem];
    
    
    [self setViewControllers:@[firstNav, secondNav, mineNav] animated:NO];
}


/**
 * 创建UITabBarItem
 */
- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    UIImage *norImage = [ImageNamed(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *serImage = [ImageNamed(selectedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:norImage selectedImage:serImage];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0xfe9b00), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return item;
}

/**
 * 设置返回按钮
 */
- (UIBarButtonItem *)addBackBtnItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:ImageNamed(@"backBarButtonItemImage") forState:0];
    [button setImage:nil forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, CGSizeMake(30, 30)};
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0,0)];
    [button addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return backItem;
}

/**
 * 返回按钮事件
 */
- (void)backBtnClick:(UIButton *)backBtn
{
    [UIView transitionWithView:[[UIApplication sharedApplication].delegate window]
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        BOOL oldState = [UIView areAnimationsEnabled];//防止设备横屏，新vc的View有异常旋转动画
                        [UIView setAnimationsEnabled:NO];
                        
                        [self dismissViewControllerAnimated:NO completion:^{
                            NSLog(@"返回到原生tabBar完成");
                        }];
                        
                        [UIView setAnimationsEnabled:oldState];
                    } completion:NULL];
}

@end
