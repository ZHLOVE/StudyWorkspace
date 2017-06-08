//
//  OKBaseViewController.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKBaseViewController.h"
#import "UIScrollView+OKRequestExtension.h"
#import "OKFrameDefiner.h"
#import "OKPubilcKeyDefiner.h"

@interface OKBaseViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *backPan;
@end

@implementation OKBaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置UITableView选中cell后，在页面返回时取消选中效果
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]] && !view.isHidden) {
            UITableView *table = ((UITableView *)view);
            for (NSIndexPath *p in table.indexPathsForSelectedRows) {
                [table deselectRowAtIndexPath:p animated:YES];
            }
            break;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //父类控制器一定要设置背景色，否则push会有拖影效果
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        OKUndeclaredSelectorLeakWarning(
            SEL selector = @selector(handleNavigationTransition:);
                                        
            if ([target respondsToSelector:selector]) { //需要滑动返回
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
                pan.delegate = self;
                [self.view addGestureRecognizer:pan];
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
                self.backPan = pan;
            }
        );        
    }
}

- (void)setShouldPanBack:(BOOL)shouldPanBack
{
    _shouldPanBack = shouldPanBack;
    self.backPan.enabled = shouldPanBack;
}

#pragma mark - ========= 初始化基类表格,子类显示 =========

- (UITableView *)plainTableView
{
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-(kStatusBarAndNavigationBarHeight+kTabbarHeight)) style:UITableViewStylePlain];
        _plainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _plainTableView.rowHeight = kDefaultCellHeight;
        _plainTableView.backgroundColor = self.view.backgroundColor;
        _plainTableView.tableFooterView = [UIView new];
        _plainTableView.dataSource = self;
        _plainTableView.delegate = self;
        [self.view addSubview:_plainTableView];
    }
    return _plainTableView;
}

- (UITableView *)groupedTableView
{
    if (!_groupedTableView) {
        _groupedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-(kStatusBarAndNavigationBarHeight+kTabbarHeight)) style:UITableViewStyleGrouped];
        _groupedTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _groupedTableView.rowHeight = kDefaultCellHeight;
        _groupedTableView.backgroundColor = self.view.backgroundColor;
        _groupedTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.01)];
        _groupedTableView.sectionHeaderHeight = 0.01;
        _groupedTableView.sectionFooterHeight = 10.0;
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

#pragma mark - 结束第一响应

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEdit];
}

- (void)endEdit
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];;
}

/**
 *  返回上一页面
 */
- (void)backBtnClick:(UIButton *)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    
    //取消子类所有请求操作
    [self cancelRequestSessionTask];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
