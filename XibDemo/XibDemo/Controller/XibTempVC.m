//
//  XibTempVC.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/2.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "XibTempVC.h"

@interface XibTempVC ()

@end

@implementation XibTempVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"name ======= %@, age ======= %f", _name, _age);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSegue======%@======%@", segue, sender);
}


@end
