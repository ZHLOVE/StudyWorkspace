//
//  AppDelegate.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

/**
 使用Workspace多工程管理项目时, 添加cocoaPod步骤:
 一.进入已经创建好的目录里面: 例如:http://ww2.sinaimg.cn/large/b04498f4gw1fbfwyf1e1yj205h047aa6.jpg
 
 二.在目录中使用命令行直接创建Podfile文件, 命令: touch Podfile
 
    2.1 在创建好的Podfile文件里面添加需要使用pod的项目和路径;
    
    2.2 如下:
 
 #每个StudyWorkspace名字就是workspace的名字,对应当前目录的名字
 workspace 'StudyWorkspace'
 
 #每个工程添加pod步骤1:->添加需要使用的工程和路径
 xcodeproj 'PodsDemo/PodsDemo.xcodeproj'
 
 #步骤2:->添加工程的target, 和xcodeproj文件所在的项目路径
 target :'PodsDemo' do
 platform :ios, '7.0'
 pod 'AFNetworking'
 pod 'SDWebImage'
 xcodeproj 'PodsDemo/PodsDemo.xcodeproj'
 end
 
 #如果还有其他工程需要添加,和步骤2一致
 
 三.写好Podfile文件后,在当前目录下使用命令安装需pod, 命令: pod install, 如下:http://ww3.sinaimg.cn/large/b04498f4gw1fbfx7o6o57j20ol0dzn3b.jpg
 
 四.安装好后, 重新打开你的xcworkspace文件,即可看到已经为需要使用的项目添加了pod管理, 如下: http://ww4.sinaimg.cn/large/b04498f4gw1fbfx8675wzj205n04uglu.jpg
 
 */

@end
