//
//  ThirdViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ThirdViewController ()
@property (nonatomic, strong) UIView *bgNavView;
@property (nonatomic, strong) UIColor *lastNavBgColor;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ThirdViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.lastNavBgColor = self.navigationController.okNavBackgroundColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.okNavBackgroundColor = self.lastNavBgColor;
    
    // 改变下拉样式
    [self changeRefreshStyle];
}

#pragma Mark - 初始化UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    if (!self.title) {
        self.title = [NSString stringWithFormat:@"测试-%zd",self.navigationController.viewControllers.count];
    }
    
    //请求所有数据
    [self requestAllData];

    //添加系统下拉刷新控件
    [self addTableRefreshControl];
}

/**
 * 添加系统下拉刷新控件
 */
- (void)addTableRefreshControl
{
    self.plainTableView.y = 0;
    _refreshControl = [[UIRefreshControl alloc]init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_refreshControl setValue:@(0) forKey:@"_style"];
    [self.plainTableView addSubview:_refreshControl];
}

/**
 * 改变下拉样式
 */
- (void)changeRefreshStyle
{
    UIView *contentView = [_refreshControl valueForKey:@"_contentView"];
    
    UIImageView *imageView = [contentView valueForKey:@"_imageView"];
    if (imageView) {
        imageView.image = [UIImage imageNamed:@"first"];
    }
    
    UIImageView *arrow = [contentView valueForKey:@"_arrow"];
    if (arrow) {
        arrow.backgroundColor = [UIColor blackColor];
        arrow.image = [UIImage imageNamed:@"icon_home2"];
        arrow.bounds = CGRectMake(0, 0, 200, 200);
        arrow.layer.cornerRadius = 10;
        arrow.layer.masksToBounds = YES;
        arrow.alpha = 1;
    }
    
    UILabel *textLab = [contentView valueForKey:@"_textLabel"];
    if (textLab) {
        textLab.bounds = CGRectMake(0, 0, 80, 20);
    }
    NSLog(@"refreshContro===%@",contentView);
}

#pragma mark -  刷新方法

/**
 * 刷新方法
 */
- (void)refresh:(UIRefreshControl *)refreshControl
{
    NSLog(@"开始刷新");
    UIView *contentView = [refreshControl valueForKey:@"_contentView"];
    
    UILabel *textLab = [contentView valueForKey:@"_textLabel"];
    if (textLab) {
        textLab.text = @"正在刷新...";
        textLab.hidden = NO;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        textLab.text = @"刷新完成";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"结束刷新");
        [refreshControl endRefreshing];
        textLab.hidden = YES;
    });
}


#pragma Mark - 请求所有数据

/**
 * 处理数据请求回调
 */
- (void)requestAllData
{
    [OKHttpRequestTools sendOKRequest:nil success:^(id returnValue) {
        ShowAlertToast([returnValue description]);
    } failure:^(NSError *error) {
        ShowAlertToast(error.domain);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[ThirdViewController new] animated:YES];
}

#pragma Mark - 滚动代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    
    CGFloat percent = (64-offset)/64;
    
    NSLog(@"scrollViewDidScroll===%.2f===%.2f",offset,percent);

    self.navigationController.okNavBackgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:percent];
}


/**
 * 监听重复点击tabBar按钮事件
 */
- (void)repeatTouchTabBarToViewController:(UIViewController *)touchVC
{
    [self.plainTableView scrollRectToVisible:CGRectMake(0, 0, self.plainTableView.width, self.plainTableView.height) animated:YES];
}


@end
