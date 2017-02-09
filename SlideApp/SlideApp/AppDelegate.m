//
//  AppDelegate.m
//  SlideApp
//
//  Created by mao wangxin on 2017/2/9.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "AppDelegate.h"
#import "MainAppVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [MainAppVC new];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
