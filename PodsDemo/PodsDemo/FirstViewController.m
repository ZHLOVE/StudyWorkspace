//
//  FirstViewController.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "FirstViewController.h"
#import "OKReachabilityManager.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [OKReachabilityManager reachabilityChangeBlock:^(AFNetworkReachabilityStatus currentStatus, AFNetworkReachabilityStatus lastReachabilityStatus) {
        
        NSLog(@"监听网络改变回调===%zd===%zd",currentStatus,lastReachabilityStatus);
    }];
}

@end
