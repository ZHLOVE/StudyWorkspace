//
//  FirstViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "FirstViewController.h"
#import "CCTabBarViewController.h"

// rgb颜色转换（16进制->10进制）
#define UIColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 * 增加tabbar
 */
- (IBAction)addTabbarAction:(UIButton *)sender
{
    CCTabBarViewController * tabbarContr = (CCTabBarViewController *)self.tabBarController;
    
    NSMutableArray *newItemArr = [NSMutableArray arrayWithArray:tabbarContr.viewControllers];
    if (newItemArr.count == 4)return;
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.title = @"UIViewController";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    vc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_property_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_property_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.title = @"双十一";
    if (self.tabBarItem.imageInsets.bottom == 20) {
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -10);
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-20, 0, 20, 0);
    }
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x282828), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0xfe9b00), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [newItemArr addObject:nav];
    tabbarContr.viewControllers = newItemArr;
}

/**
 * 换肤
 */
- (IBAction)reduceTabbarItem
{
    CCTabBarViewController * tabbarContr = (CCTabBarViewController *)self.tabBarController;
    tabbarContr.tabBar.backgroundImage = [self imageWithColor:[UIColorFromHex(0x8CC63F) colorWithAlphaComponent:0.2]];
    
    NSMutableArray *newItemArr = [NSMutableArray arrayWithArray:tabbarContr.viewControllers];
    
    for (UINavigationController *nav in newItemArr) {
        UITabBarItem *item = nav.viewControllers[0].tabBarItem;
        item.titlePositionAdjustment = UIOffsetMake(0, -10);
        item.imageInsets = UIEdgeInsetsMake(-20, 0, 20, 0);
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x282828), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0xfe9b00), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    
    self.tabBarItem.image = [[UIImage imageNamed:@"tabbar_cloudstore_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_cloudstore_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.title = @"抢购";
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
