//
//  SecondViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "SecondViewController.h"
#import "OKOtherTabBarVC.h"

@implementation APLAsyncImageActivityItemProvider


- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return [[UIImage alloc] init];
}

- (id)item
{
    return [UIImage imageNamed:@"icon_home2"];
}

- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController thumbnailImageForActivityType:(NSString *)activityType suggestedSize:(CGSize)size
{
    return [UIImage imageNamed:@"tabbar_cloudstore_h"];
}

@end

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)shareAction:(UIButton *)sender
{
    APLAsyncImageActivityItemProvider *aiImageItemProvider = [APLAsyncImageActivityItemProvider new];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[aiImageItemProvider] applicationActivities:nil];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //iPhone, present activity view controller as is
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
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
