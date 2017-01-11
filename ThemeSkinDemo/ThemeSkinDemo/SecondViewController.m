//
//  SecondViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "SecondViewController.h"
#import "CCTabBar2VC.h"
#import "ThirdViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) NSString *myAddress;
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
                        
                        CCTabBar2VC *newTabBar = [[CCTabBar2VC alloc] init];
                        [self presentViewController:newTabBar animated:NO completion:^{
                            NSLog(@"切换到新的原生tabBar完成");
                        }];
                        
                        [UIView setAnimationsEnabled:oldState];
                    } completion:NULL];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ThirdViewController *vc = [[ThirdViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"测试";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
