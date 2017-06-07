//
//  SecondViewController.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/5/19.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
