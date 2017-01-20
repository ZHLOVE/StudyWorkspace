//
//  OKBaseViewController.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKBaseViewController.h"
#import "UITableView+OKRequestExtension.h"

@interface OKBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation OKBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置UITableView选中cell后，在页面返回时取消选中效果
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]&&!view.isHidden) {
            UITableView *table = ((UITableView *)view);
            for (NSIndexPath *p in table.indexPathsForSelectedRows) {
                [table deselectRowAtIndexPath:p animated:YES];
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //添加全屏右滑动返回
    [self addScreenEdgePanGesture];
}


#pragma mark - 添加全屏右滑动返回

/**
 * 添加全屏右滑动返回
 */
- (void)addScreenEdgePanGesture
{
    //用系统的方法,全屏滑动返回
    if (self.navigationController.viewControllers.count > 1) {
        id target = self.navigationController.interactivePopGestureRecognizer.delegate;
        //忽略警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        SEL selector = @selector(handleNavigationTransition:);
#pragma clang diagnostic pop
        
        if ([target respondsToSelector:selector]) { //需要滑动返回
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
            pan.delegate = self;
            [self.view addGestureRecognizer:pan];
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

#pragma mark - ========= 初始化基类表格,子类显示 =========

- (UITableView *)plainTableView
{
    if (!_plainTableView) {
        _plainTableView = [UITableView plainTableView];
        _plainTableView.dataSource = self;
        _plainTableView.delegate = self;
        [self.view addSubview:_plainTableView];
    }
    return _plainTableView;
}

- (UITableView *)groupedTableView
{
    if (!_groupedTableView) {
        _groupedTableView = [UITableView groupedTableView];
        _groupedTableView.dataSource = self;
        _groupedTableView.delegate = self;
        [self.view addSubview:_groupedTableView];
    }
    return _groupedTableView;
}

- (NSMutableArray *)tableDataArr
{
    if (!_tableDataArr) {
        NSMutableArray *tableDataArr = [NSMutableArray array];
        self.tableDataArr = tableDataArr;
    }
    return _tableDataArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"数据源===%zd",indexPath.row];
    return cell;
}

#pragma mark - 管理子类请求对象

/**
 * 子类请求对象数组
 */
- (NSMutableArray<NSURLSessionDataTask *> *)sessionDataTaskArr
{
    if (!_sessionDataTaskArr) {
        NSMutableArray *sessionDataTaskArr = [NSMutableArray array];
        self.sessionDataTaskArr = sessionDataTaskArr;
    }
    return _sessionDataTaskArr;
}

/**
 * 父类释放时取消子类所有请求操作
 */
- (void)cancelRequestSessionTask
{
    if (_sessionDataTaskArr.count==0) return;
    
    for (NSURLSessionDataTask *sessionTask in self.sessionDataTaskArr) {
        if ([sessionTask isKindOfClass:[NSURLSessionDataTask class]]) {
            [sessionTask cancel];
        }
    }
    //清除所有请求对象
    [self.sessionDataTaskArr removeAllObjects];
}


- (void)dealloc
{
    //取消子类所有请求操作
    [self cancelRequestSessionTask];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

@end
