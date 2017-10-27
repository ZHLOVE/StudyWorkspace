//
//  ViewController.m
//  ApiDemo
//
//  Created by mao wangxin on 2017/6/12.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ViewController.h"
#import <UIViewController+OKExtension.h>
#import <UIView+OKTool.h>
#import <OKAlertView.h>

#define HEIGHT_REFRESH  60

@interface ViewController ()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.plainTableView.automaticShowTipView = YES;

    self.plainTableView.rowHeight = 60;

    //要添加测试的VC
    [self refreshTableData];

    //添加系统下拉控件
    [self addTableViewRefreshControl];
}

/**
 * 添加系统下拉控件
 */
- (void)addTableViewRefreshControl
{
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [_refreshControl addTarget:self action:@selector(refreshTableData) forControlEvents:UIControlEventValueChanged];
    self.plainTableView.refreshControl = _refreshControl;
}

/**
 * 要添加测试的VC，在此处把类名加上即可
 */
- (void)refreshTableData
{
    [self.tableDataArr removeAllObjects];
    [self.tableDataArr addObjectsFromArray:@[@{@"StudyInvocationVC":@"NSInvocation的使用"},
                                             @{@"StudyMessageSendVC":@"OC消息转发机制"},
                                             @{@"StudyUserDefaultVC":@"UserDefault研究"},
                                             ]];
    [self.plainTableView reloadData];

}

// 设置刷新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    decelerate = YES;
    if (scrollView.contentOffset.y < HEIGHT_REFRESH) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新"];
        });
        [_refreshControl beginRefreshing];

        [self refreshTableData];

        // 结束刷新
        showAlertToastDelay(nil, @"刷新成功", 2, ^{
            [_refreshControl endRefreshing];
        });
    }
}

// 设置刷新状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= HEIGHT_REFRESH) {
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
    else if (!scrollView.decelerating) {
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开刷新"];
    }
}

- (IBAction)tapScrollView:(UITapGestureRecognizer *)sender {
    NSLog(@"tapScrollView");
}

#pragma mark - /*** UITaleviewDelegate ***/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        [cell layoutLeftLineMargins];
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
    
    NSDictionary *celLDic = [self.tableDataArr objectAtIndex:indexPath.row];
    NSString *className = celLDic.allKeys[0];
    [self pushToViewController:className propertyDic:@{@"title":className}];
}


@end
