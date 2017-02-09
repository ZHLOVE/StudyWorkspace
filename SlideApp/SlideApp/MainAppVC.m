//
//  MainAppVC.m
//  SlideApp
//
//  Created by mao wangxin on 2017/2/9.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "MainAppVC.h"
#import "SlideAppTabBarVC.h"

//获取屏幕宽度
#define Screen_Width            ([UIScreen  mainScreen].bounds.size.width)
//获取屏幕高度
#define Screen_Height           ([UIScreen mainScreen].bounds.size.height)

@interface MainAppVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *plainTableView;
@property (nonatomic, strong) SlideAppTabBarVC *slideAppTabBarVC;
@end

@implementation MainAppVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self plainTableView];
    
    [self slideAppTabBarVC];
}

/**
 *  初始化子控制器，当做app主视图使用
 */
- (SlideAppTabBarVC *)slideAppTabBarVC
{
    if (!_slideAppTabBarVC) {
        _slideAppTabBarVC = [[SlideAppTabBarVC alloc] init];
        _slideAppTabBarVC.edgesForExtendedLayout = UIRectEdgeNone;
//        _slideAppTabBarVC.view.height += 49;
        [self.view addSubview:_slideAppTabBarVC.view];
        [self addChildViewController:_slideAppTabBarVC];
    }
    return _slideAppTabBarVC;
}

#pragma mark - ========= 初始化基类表格,子类显示 =========

- (UITableView *)plainTableView
{
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _plainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _plainTableView.rowHeight = 80;
        _plainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _plainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.01)];
        _plainTableView.tableFooterView = [UIView new];
        _plainTableView.dataSource = self;
        _plainTableView.delegate = self;
        [self.view addSubview:_plainTableView];
    }
    return _plainTableView;
}

#pragma Mark - 表格代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}

@end
