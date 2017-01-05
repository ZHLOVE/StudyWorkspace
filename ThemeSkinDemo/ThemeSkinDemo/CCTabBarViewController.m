//
//  CCTabBarViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

//定义UIImage对象，图片多次被使用到
#define ImageNamed(name)                [UIImage imageNamed:name]
//rgb颜色
#define RGB(r,g,b)                      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f                                                                                 alpha:1.f]
//rgb颜色,  a:透明度
#define RGBA(r,g,b,a)                   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f                                                                                 alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define UIColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//主色 (黄色)
#define Color_Main                      UIColorFromRGB(0xfe9b00)

@interface CCTabBarViewController ()

@end

@implementation CCTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化tabBar控制器
    [self initTabBarVCS];
}


- (void)initTabBarVCS
{
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    firstVC.tabBarItem = [self createTabBarItemWithTitle:@"首页" imageName:@"tabbar_home_n" selectedImage:@"tabbar_home_h"];
    firstVC.title = @"首页";
    
    
    
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVc];
    secondVc.tabBarItem = [self createTabBarItemWithTitle:@"发现" imageName:@"tabbar_property_n" selectedImage:@"tabbar_property_h"];
    secondVc.title = @"发现";
    
    
    
    ThirdViewController *mineVC = [[ThirdViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem = [self createTabBarItemWithTitle:@"我的" imageName:@"tabbar_my_n" selectedImage:@"tabbar_my_h"];
    mineVC.title = @"我的";
    
    
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
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x8CC63F), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    return item;
}

@end
