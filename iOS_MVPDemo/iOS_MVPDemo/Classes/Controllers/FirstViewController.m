//
//  FirstViewController.m
//  iOS_MVPDemo
//
//  Created by mao wangxin on 2017/8/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "FirstViewController.h"
#import "ListDataCell.h"
#import <UIViewController+OKExtension.h>

static NSString *cellID         = @"ListDataCell";
#define WEAKSELF(weakSelf)      __weak __typeof(&*self)weakSelf = self;

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self requestData];
}

/**
 * 初始化
 */
- (ListDataPresenter *)presenter
{
    if(!_presenter){
        _presenter = [[ListDataPresenter alloc] init];
        _presenter.tableView = _tableView;
        _presenter.viewController = self;
    }
    return _presenter;
}

/**
 * 请求数据
 */
- (void)requestData
{
    kRequestCodeKey = @"subcateId";//此接口在请求时底层用这个字段判断请求状态
    self.tableView.tableFooterView = [UIView new];
    WEAKSELF(weakSelf)
    [self.tableView addheaderRefresh:^{
        [weakSelf.presenter reqPageListData:YES callBack:^(NSArray *array) {
            [weakSelf refreshTableWithDataArr:array];
        }];
    } footerBlock:^{
        [weakSelf.presenter reqPageListData:NO callBack:^(NSArray *array) {
            [weakSelf refreshTableWithDataArr:array];
        }];
    }];
}

/**
 * 刷新
 */
- (void)refreshTableWithDataArr:(NSArray *)array
{
    self.tableDataArr = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
}

#pragma mark -===========UITableViewDelegete===========

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSDictionary *dic = self.tableDataArr[indexPath.row];
    cell.descTextLab.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pushToViewController:@"FirstViewController" propertyDic:@{@"title":@"单元测试"}];
}

@end
