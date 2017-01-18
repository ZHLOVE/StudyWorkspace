//
//  SecondViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "SecondViewController.h"
#import "OKOtherTabBarVC.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 * 切换模块
 */
- (IBAction)changeModouleAction:(UIButton *)sender
{
    [UIView transitionWithView:[[UIApplication sharedApplication].delegate window]
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        BOOL oldState = [UIView areAnimationsEnabled];//防止设备横屏，新vc的View有异常旋转动画
                        [UIView setAnimationsEnabled:NO];
                        
                        OKOtherTabBarVC *newTabBar = [[OKOtherTabBarVC alloc] init];
                        [self presentViewController:newTabBar animated:NO completion:^{
                            NSLog(@"切换到新的原生tabBar完成");
                        }];
                        
                        [UIView setAnimationsEnabled:oldState];
                    } completion:NULL];
}

@end
