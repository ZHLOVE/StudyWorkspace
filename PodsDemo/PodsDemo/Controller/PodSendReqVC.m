//
//  PodSendReqVC.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/6/2.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PodSendReqVC.h"
#import "OKHttpRequestTools+OKExtension.h"
#import <MJRefresh.h>

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define TestRequestUrl      @"http://lib3.wap.zol.com.cn/index.php?c=Advanced_List_V1&keyword=808.8GB%205400%E8%BD%AC%2032MB&noParam=1&priceId=noPrice&num=15"

@interface PodSendReqVC ()
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation PodSendReqVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.plainTableView.rowHeight = 60;
    
    WEAKSELF(weakSelf)
    [self.plainTableView addheaderRefresh:^{
        [weakSelf requestData:YES];
    } footerBlock:^{
        [weakSelf requestData:NO];
    }];
    
    //刷新数据
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新数据" style:UIBarButtonItemStylePlain target:self.plainTableView.mj_header action:@selector(beginRefreshing)];
}


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

/**
 * 发送请求
 */
- (void)requestData:(BOOL)firstPage
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
    model.requestUrl = TestRequestUrl; //可以试着把地址写错,测试请求失败的场景
    
    model.loadView = self.view;
    model.dataTableView = self.plainTableView;
    model.attemptRequestWhenFail = YES;
//    model.sessionDataTaskArr = self.sessionDataTaskArr;
//    model.requestCachePolicy = RequestStoreCacheData;
    
    NSLog(@"发送请求中====%zd",self.pageNum);
    [OKHttpRequestTools sendExtensionRequest:model success:^(id returnValue) {
        if (self.params != info) return;
        if (firstPage) {
            [self.tableDataArr removeAllObjects];
        }
        
        [self.tableDataArr addObjectsFromArray:returnValue[@"data"]];
        [self.plainTableView reloadData];
    } failure:^(NSError *error) {
        if (!firstPage) self.pageNum --;
    }];
}

- (void)dealloc
{
    NSLog(@"DemoVC dealloc");
}

@end
