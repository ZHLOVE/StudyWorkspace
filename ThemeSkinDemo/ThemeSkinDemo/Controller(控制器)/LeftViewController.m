//
//  FiveViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/2/8.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "LeftViewController.h"
#import "FirstViewController.h"

@interface LeftViewController ()
@property (nonatomic, strong) FirstViewController *firstVC;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.plainTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.plainTableView.rowHeight = 80;
    
    [self firstVC];
}

/**
 *  初始化子控制器，当做视图使用
 */
- (FirstViewController *)firstVC
{
    if (!_firstVC) {
        _firstVC = [[FirstViewController alloc] init];
        _firstVC.edgesForExtendedLayout = UIRectEdgeNone;
        _firstVC.view.height += 49;
        [self.view addSubview:_firstVC.view];
        [self addChildViewController:_firstVC];
        [self addLeftBarButtonItem:@"开关" target:_firstVC selector:@selector(converLeftViewAction:)];
    }
    return _firstVC;
}

#pragma Mark - 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_firstVC converLeftViewAction:nil];
    [self.navigationController pushViewController:[OKBaseViewController new] animated:YES];
}

@end
