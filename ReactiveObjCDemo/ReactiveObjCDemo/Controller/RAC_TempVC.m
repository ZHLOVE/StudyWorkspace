//
//  RAC_TempVC.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "RAC_TempVC.h"

@interface RAC_TempVC ()

@end

@implementation RAC_TempVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 * 点击事件1
 */
- (IBAction)btnAction:(UIButton *)sender
{
    // 通知上个ViewController做事情
    if (self.subject) {
        [self.subject sendNext:@"哈哈"];
    }
}

- (void)dealloc
{
    NSLog(@"ThreeViewController 销毁了");
}

@end
