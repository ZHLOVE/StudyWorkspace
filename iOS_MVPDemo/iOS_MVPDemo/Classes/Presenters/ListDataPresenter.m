//
//  ListDataPresenter.m
//  iOS_MVPDemo
//
//  Created by mao wangxin on 2017/8/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ListDataPresenter.h"
#import "ListDataModel.h"
#import <MJExtension.h>

//请求列表地址
#define kRequestUrl    @"http://lib3.wap.zol.com.cn/index.php?c=Advanced_List_V1&keyword=808.8GB%205400%E8%BD%AC%2032MB&noParam=1&priceId=noPrice&num=15"

@interface ListDataPresenter ()
@property (nonatomic, strong) ListDataModel *listDataModel;
@property (nonatomic, strong) NSMutableArray *tableDataArr;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation ListDataPresenter

- (instancetype)initWithView:(UITableView *)tableView viewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _viewController = viewController;
    }
    return self;
}

- (NSMutableArray *)tableDataArr
{
    if (!_tableDataArr) {
        _tableDataArr = [NSMutableArray array];
    }
    return _tableDataArr;
}

/**
 * 分页请求列表数据
 */
- (void)reqPageListData:(BOOL)firstPage callBack:(void(^)(NSArray *array))block
{
    if (firstPage) {
        self.pageNum = 1;
    } else {
        self.pageNum ++;
    }
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[@"page"] = @(self.pageNum);
    self.params = info;
    
    OKHttpRequestModel *model = [[OKHttpRequestModel alloc] init];
    model.requestType = HttpRequestTypeGET;
    model.parameters = info;
    model.requestUrl = kRequestUrl; //可以试着把地址写错,测试请求失败的场景
    
    model.loadView = _tableView.superview;
    model.dataTableView = _tableView;
    
    [OKHttpRequestTools sendExtensionRequest:model success:^(id returnValue) {
        if (self.params != info) return;
        if (firstPage) {
            [self.tableDataArr removeAllObjects];
        }
        [self.tableDataArr addObjectsFromArray:returnValue[@"data"]];
        
        if (block) {
            block(self.tableDataArr);
        }
        
    } failure:^(NSError *error) {
        if (!firstPage) self.pageNum --;
    }];
}

@end
