//
//  FourthViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/10.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "FourthViewController.h"
#import "ThirdViewController.h"
#import <UIView+OKExtension.h>

@interface FourthViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) ThirdViewController *thirdVC;
@property (nonatomic, strong) UITableView *plainTableView;
@end

@implementation FourthViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.thirdVC = (ThirdViewController *)self.parentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self plainTableView];
}

//滚动到顶部
- (void)scrollToTop
{
    [self.plainTableView scrollRectToVisible:CGRectMake(0, 0, self.view.width, self.view.height-49) animated:YES];
}

#pragma Mark - 初始化UI

- (UITableView *)plainTableView
{
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49) style:UITableViewStylePlain];
        _plainTableView.dataSource = self;
        _plainTableView.delegate = self;
        _plainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        _plainTableView.tableFooterView = [UIView new];
        [self.view addSubview:_plainTableView];
    }
    return _plainTableView;
}

#pragma Mark - 表格代理

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}

#pragma Mark - 滚动代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    
    CGFloat percent = (64-offset)/64;
    
    NSLog(@"scrollViewDidScroll===%.2f===%.2f",offset,percent);
    
    //在滚动时设置颜色
    [self.thirdVC changeNavBgColor:percent];
}

#pragma mark - 刷新数据

//刷新数据1
- (void)refreshUI1WithData:(id)requestData
{
    
}

//刷新数据2
- (void)refreshUI2WithData:(id)requestData
{
    
}

//刷新数据3
- (void)refreshUI3WithData:(id)requestData
{
    
}

- (void)dealloc
{
    NSLog(@"FourthViewController-------dealloc");
}

@end
