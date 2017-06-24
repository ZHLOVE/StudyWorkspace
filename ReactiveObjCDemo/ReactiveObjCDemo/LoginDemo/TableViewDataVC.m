//
//  TableViewDataVC.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "TableViewDataVC.h"
#import "TableDataModel.h"
#import <UIViewController+OKExtension.h>
#import "UIScrollView+OKRequestExtension.h"

@interface TableViewDataVC ()
@property (nonatomic, strong) RequestViewModel *requesViewModel;
@end

@implementation TableViewDataVC

- (RequestViewModel *)requesViewModel
{
    if (!_requesViewModel) {
        _requesViewModel = [[RequestViewModel alloc] init];
    }
    return _requesViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.plainTableView.dataSource = self.requesViewModel;
    self.requesViewModel.tableView = self.plainTableView;
    self.plainTableView.netErrorTipString = @"运营商的网络有问题哦";
    self.plainTableView.reqFailTipString = @"尼玛后台又出问题了啊";
    self.plainTableView.emptyDataBtnTitle = @"再试一次吧";
    self.plainTableView.emptyDataActionTarget = self;
    self.plainTableView.emptyDataActionSEL = @selector(refreshData);
    
    self.requesViewModel.vcView = self.view;
    
    // 执行请求
    [self refreshData];
    
    //刷新数据
    [self addRightBarButtonItem:@"刷新" target:self selector:@selector(refreshData)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[TableViewDataVC new] animated:YES];
}

/**
 * 刷新数据
 */
- (void)refreshData
{
    // 执行请求
    [self.requesViewModel.reuqesCommand execute:nil];
}

- (void)dealloc
{
    NSLog(@"TableViewDataVC 销毁了 dealloc");
}

@end
