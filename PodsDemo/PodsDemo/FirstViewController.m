//
//  FirstViewController.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "FirstViewController.h"
<<<<<<< HEAD
#import "OKReachabilityManager.h"
=======
#import <UIImageView+WebCache.h>
#import "OKAlertController.h"
>>>>>>> cded35f636d131a8c0c80f837c10ed8c533d5fb7

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
