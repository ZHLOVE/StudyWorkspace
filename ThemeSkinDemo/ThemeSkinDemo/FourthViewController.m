//
//  FourthViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/10.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "FourthViewController.h"
#import "ThirdViewController.h"

@interface FourthViewController ()
@property (nonatomic, weak) ThirdViewController *thirdVC;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSLog(@"FourthViewController初始化=====%@===%@",self.thirdVC,self.parentViewController);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
    
    self.thirdVC = (ThirdViewController *)self.parentViewController;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"FourthViewController的父控制器=====%@===%@",self.thirdVC,self.parentViewController);
    
    [self.thirdVC performSelector:@selector(testMethod) withObject:nil];
}

- (void)dealloc
{
    NSLog(@"FourthViewController-------dealloc");
}

@end
