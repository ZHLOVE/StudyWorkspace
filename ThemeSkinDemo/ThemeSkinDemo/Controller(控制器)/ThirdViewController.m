//
//  ThirdViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "OKHttpRequestTools+OKExtension.h"

#define TestRequestUrl1      @"http://api.cnez.info/product/getProductList/1"
#define TestRequestUrl2      @"http://lib3.wap.zol.com.cn/index.php?c=Advanced_List_V1&keyword=808.8GB%205400%E8%BD%AC%2032MB&noParam=1&priceId=noPrice&num=15"

@interface ThirdViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *statusMaskView;
@property (nonatomic, strong) UIView *bgNavView;
@property (nonatomic, strong) UIColor *lastNavBgColor;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, assign) CGFloat lastOffset;
@end

@implementation ThirdViewController

- (UIView *)statusMaskView
{
    if (!_statusMaskView) {
        _statusMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
        _statusMaskView.backgroundColor = [UIColor whiteColor];
        [self.view.window addSubview:_statusMaskView];
    }
    return _statusMaskView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.lastNavBgColor = self.navigationController.okNavBackgroundColor;
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.navigationBar.y = 20;
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.okNavBackgroundColor = self.lastNavBgColor;
    
    // 改变下拉样式
    [self changeRefreshStyle];
    
    //向上滑动隐藏导航栏
    //[self hidesBarsWhenSwipe];
}

/**
 * 向上滑动隐藏导航栏
 */
- (void)hidesBarsWhenSwipe
{
    //向上滑动隐藏导航栏: 系统属性
    self.navigationController.hidesBarsOnSwipe = YES;
    self.navigationController.hidesBarsOnTap = NO;
    
    //导航透明
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    self.navigationController.navigationBar.translucent = YES;
}

/**
 * 导航代理方法
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"willShowViewController===%@===%zd",viewController,navigationController.viewControllers.count);
    //此方法需要添加代理, 警告: 设置了代理后在滑动时与父类的全品滑动手势冲突
    //self.navigationController.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"didShowViewController===%@",viewController);
    //此方法需要添加代理, 警告: 设置了代理后在滑动时与父类的全品滑动手势冲突
    //self.navigationController.delegate = self;
}

#pragma Mark - 初始化UI

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    
    if (!self.title) {
        self.title = [NSString stringWithFormat:@"测试-%zd",self.navigationController.viewControllers.count];
    }
    
    //添加系统下拉刷新控件
    [self addTableRefreshControl];
}

#pragma mark -===========UIRefreshControl刷新控件===========

/**
 * 添加系统下拉刷新控件
 */
- (void)addTableRefreshControl
{
    self.plainTableView.height = Screen_Height;
    self.plainTableView.sectionIndexColor = [UIColor redColor];
    self.plainTableView.sectionIndexBackgroundColor = [UIColor greenColor];
    self.plainTableView.sectionIndexTrackingBackgroundColor = [UIColor orangeColor];
    _refreshControl = [[UIRefreshControl alloc] init];
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

/**
 * 刷新状态
 */
- (void)endRefreshStyle:(UIRefreshControl *)refreshControl
{
    UIView *contentView = [refreshControl valueForKey:@"_contentView"];
    UILabel *textLab = [contentView valueForKey:@"_textLabel"];
    textLab.hidden = NO;
    NSString *tipStr = nil;
    
    if (refreshControl) {
       tipStr = @"正在刷新...";
    } else if (refreshControl.isRefreshing) {
        tipStr = @"刷新完成";
    } else {
        tipStr = @"刷新失败";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        textLab.text = tipStr;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
        textLab.hidden = YES;
    });
}

#pragma mark -  刷新方法

/**
 * 刷新方法
 */
- (void)refresh:(UIRefreshControl *)refreshControl
{
    //请求所有数据
    OKHttpRequestModel *model = [[OKHttpRequestModel alloc] init];
    model.requestType = HttpRequestTypeGET;
    model.parameters = @{@"page":@"1"};
    model.requestUrl = TestRequestUrl2;
    
    model.loadView = self.view;
    model.dataTableView = self.plainTableView;
//    model.sessionDataTaskArr = self.sessionDataTaskArr;
//    model.requestCachePolicy = RequestStoreCacheData;
    
    [OKHttpRequestTools sendExtensionRequest:model success:^(id returnValue) {
        [self.tableDataArr removeAllObjects];
        [self.tableDataArr addObjectsFromArray:returnValue[@"data"]];
        [self.plainTableView reloadData];        
        // 刷新状态
        [self endRefreshStyle:refreshControl];
        
    } failure:^(NSError *error) {
        ShowAlertToast(error.domain);
        // 刷新状态
        [self endRefreshStyle:refreshControl];
    }];
}

#pragma mark -===========UITableViewDelegate===========

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dic = self.tableDataArr[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.textLabel.numberOfLines = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[ThirdViewController new] animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"commitEditingStyle===%@",indexPath);
}

#pragma mark -===========UIScrollViewDelegate===========

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = scrollView.contentOffset.y;
    scrollView.bounces = y > Screen_Height ? NO : YES;
    CGFloat value = y-self.lastOffset;
    CGFloat barY = self.navigationController.navigationBar.y;
    
    if (y>0) {
        barY -= value;
        self.statusMaskView.alpha = fabs((barY-20)/44.0);
    }
    
    if (barY>=20) {
        barY = 20;
        self.statusMaskView.alpha = 0;
        self.plainTableView.height = Screen_Height;
        
    } else if (barY<=-24) {
        barY = -24;
        self.statusMaskView.alpha = 1;
        self.plainTableView.height = Screen_Height-(kStatusBarHeight+kTabbarHeight);
    }
    
    self.lastOffset = y;
    
    self.navigationController.navigationBar.y = barY;
    self.plainTableView.y = barY-20;
}

/**
 * 监听重复点击tabBar按钮事件
 */
- (void)repeatTouchTabBarToViewController:(UIViewController *)touchVC
{
    [self.plainTableView scrollRectToVisible:CGRectMake(0, 0, self.plainTableView.width, self.plainTableView.height) animated:YES];
}

@end
