//
//  AppDelegate.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "AppDelegate.h"
#import "CCTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [CCTabBarViewController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
