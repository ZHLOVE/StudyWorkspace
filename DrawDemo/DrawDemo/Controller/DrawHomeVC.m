//
//  DrawHomeVC.m
//  DrawDemo
//
//  Created by mao wangxin on 2017/6/5.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "DrawHomeVC.h"
#import <UIViewController+OKExtension.h>

@interface DrawHomeVC ()

@end

@implementation DrawHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)buttonAction:(UIButton *)sender
{
    [self pushToViewController:@"DrawFirstVC" propertyDic:@{@"title":@"核心动画"}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
