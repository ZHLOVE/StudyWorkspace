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
@property (nonatomic, weak) ThirdViewController *thirdVC;
@end

@implementation FourthViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.thirdVC = (ThirdViewController *)self.parentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.plainTableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-47);
}

//滚动到顶部
- (void)scrollToTop
{
    [self.plainTableView scrollRectToVisible:CGRectMake(0, 0, self.plainTableView.width, self.plainTableView.height) animated:YES];
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
