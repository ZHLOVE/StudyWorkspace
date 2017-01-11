//
//  ThirdViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "ThirdViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import <UIView+OKExtension.h>
#import "FourthViewController.h"

@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) FourthViewController *fourthVC;
@property (nonatomic, strong) UITableView *plainTableView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ThirdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self fourthVC];
    
    self.plainTableView.tableHeaderView = self.fourthVC.view;
}

- (void)testMethod
{
    NSLog(@"ThirdViewController--------testMethod");
}

/**
 *  初始化子控制球
 */
- (FourthViewController *)fourthVC
{
    if (!_fourthVC) {
        _fourthVC = [[FourthViewController alloc] init];
        _fourthVC.edgesForExtendedLayout = UIRectEdgeNone;
        _fourthVC.view.size = CGSizeMake(self.view.width, 400);
        [self addChildViewController:_fourthVC];
    }
    return _fourthVC;
}

- (UITableView *)plainTableView
{
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _plainTableView.dataSource = self;
        _plainTableView.delegate = self;
        _plainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        _plainTableView.tableFooterView = [UIView new];
        [self.view addSubview:_plainTableView];
    }
    return _plainTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"数据源---%zd",indexPath.row];
    return cell;
}

@end
