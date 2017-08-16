//
//  FiveViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/2/8.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "LeftViewController.h"
#import "FirstViewController.h"
#import "UITabBar+BadgeView.h"

@interface LeftViewController ()
@property (nonatomic, strong) FirstViewController *firstVC;
@property (nonatomic, strong) UIView *scrollView;
@property (nonatomic, strong) UIView *overView1;
@property (nonatomic, strong) UIView *overView2;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.plainTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.plainTableView.rowHeight = 80;
    
    [self firstVC];
    
    //添加自定义导航滚动视图
    [self addCustomNavigationView];
}

/**
 * 添加自定义导航滚动视图
 */
- (void)addCustomNavigationView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    scrollView.contentSize = CGSizeMake(150, 40*2);
    self.scrollView = scrollView;
    
    UIView *overView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.width, scrollView.height)];
    overView1.backgroundColor = [UIColor brownColor];
    self.overView1 = overView1;
    
    UIView *overView2 = [[UIView alloc] initWithFrame:CGRectMake(0, overView1.height, scrollView.width, scrollView.height)];
    overView2.backgroundColor = [UIColor grayColor];
    self.overView2 = overView2;
    
    [scrollView addSubview:overView1];
    [scrollView addSubview:overView2];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scrollView];
}

/**
 * 监听重复点击tabBar按钮事件
 */
- (void)repeatTouchTabBarToViewController:(UIViewController *)touchVC
{
    NSLog(@"touchVC===%@===%@===%@",touchVC,self,self.tabBarController);
    //设置小红点
    [self.tabBarController.tabBar showBadgeOnItemIndex:0];
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
        [self addLeftBarButtonItem:@"开关" titleColor:[UIColor redColor] target:_firstVC selector:@selector(converLeftViewAction:)];
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
