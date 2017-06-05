//
//  DrawAppLeftVC.m
//  DrawDemo
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "DrawAppLeftVC.h"
#import <OKPubilcKeyDefiner.h>
#import <UIViewController+OKExtension.h>

@interface DrawAppLeftVC ()

@end

@implementation DrawAppLeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    headView.backgroundColor = [UIColor orangeColor];
    
    self.plainTableView.tableHeaderView = headView;
    self.plainTableView.rowHeight = 80;
    
    //要添加测试的VC
    [self setupTableData];
}

/**
 * 要添加测试的VC，在此处把类名加上即可
 */
- (void)setupTableData
{
    [self.tableDataArr addObjectsFromArray:@[@{@"DrawCoreAnimationVC":@"核心动画"},
                                             @{@"DrawCircleVC":@"画圈"},
                                             @{@"DrawQuartz2DVC":@"Quartz2D绘图"},
                                             @{@"DrawChartVC":@"统计折线图"},
                                             @{@"DrawTransitionVC":@"百叶窗动画"},
                                             @{@"DrawCGPathVC":@"画笔涂鸦"},
                                             ]];
}

#pragma Mark - 表格代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
    }
    NSDictionary *celLDic = [self.tableDataArr objectAtIndex:indexPath.row];
    NSString *className = celLDic.allKeys[0];
    cell.textLabel.text = className;
    cell.detailTextLabel.text = celLDic[className];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //关闭侧滑视图
    SEL selector = @selector(showAppSliderView:);
    if ([self.tabBarController respondsToSelector:selector]) {
        [self.tabBarController performSelector:selector withObject:@(NO)];
    }
    
    UINavigationController *VCNav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
    
    NSDictionary *celLDic = [self.tableDataArr objectAtIndex:indexPath.row];
    NSString *className = celLDic.allKeys[0];
    [VCNav pushToViewController:className propertyDic:@{@"title":className}];
}

@end
