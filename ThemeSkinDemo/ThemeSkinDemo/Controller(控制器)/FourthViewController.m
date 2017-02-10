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
@end

@implementation FourthViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.plainTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-47);
}

#pragma Mark - 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[OKBaseViewController new] animated:YES];
}

- (void)dealloc
{
    NSLog(@"FourthViewController-------dealloc");
}

@end
