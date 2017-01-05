//
//  ThirdViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (nonatomic, strong) UIView *bgNavView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    
    //设置导航背景色
    [self setCustomNavBgColor:self.navigationController.navigationBar color:[UIColor whiteColor]];
}

/**
 *  设置导航栏背景色
 */
-(void)setCustomNavBgColor:(UIView *)superView color:(UIColor *)color
{
    if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectFilterView")]) {
        //在这里可设置背景色，用一个变量引住导航背景view,方便在其他地方改变颜色
        self.bgNavView = superView;
        self.bgNavView.backgroundColor = color;
    }
    
    for (UIView *view in superView.subviews) {
        [self setCustomNavBgColor:view color:color];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    
    CGFloat percent = (64+offset)/64;
    
    NSLog(@"scrollViewDidScroll===%.2f===%.2f",offset,percent);
    
    //在滚动时设置颜色
    self.bgNavView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:percent];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewID = @"tableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"数据源====%zd",indexPath.row];
    return cell;
}

@end
