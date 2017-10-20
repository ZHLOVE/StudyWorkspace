//
//  TimeLineVC.m
//  TimeLineDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "TimeLineVC.h"
#import "TimeLineCell.h"
#import "TimeLineViewModel.h"
#import <OKPubilcKeyDefiner.h>
#import "OKHttpRequestTools+OKExtension.h"
#import <UIViewController+OKExtension.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "OKTableDelegateOrDataSource.h"
#import <OKAlertView.h>
#import <UIView+OKTool.h>

//请求数据地址
#define Url_DocList  @"http://direct.wap.zol.com.cn/bbs/getRecommendBook.php?ssid=%242a%2407%24403c8f4a8f512e730e163b7ad3d6b3123e6d5c15525674a76080dbb7f8cacc42&v=3.0&vs=iph561"

@interface TimeLineVC ()
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *bbsid;
@property (nonatomic, strong) OKTableDelegateOrDataSource *tableDelegateAndDataSource;
@end

@implementation TimeLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plainTableView.reqEmptyTipString = @"暂无数据哦";
    self.plainTableView.reqFailTipString = @"请求失败,请耐心重试哦~";
    self.plainTableView.footerTipString = @"—— 没有更多数据啦 ——";
    self.plainTableView.delegate = self.tableDelegateAndDataSource;
    self.plainTableView.dataSource = self.tableDelegateAndDataSource;
    
    WEAKSELF
    [self.plainTableView addheaderRefresh:^{
        [weakSelf requestData:YES];
    } footerBlock:^{
        [weakSelf requestData:NO];
    }];
    
    //点击导航条按钮刷新数据
    [self addNavigationRightItem];
}

/**
 * 刷新数据
 */
- (void)addNavigationRightItem
{
    WEAKSELF
    [self addRightBarButtonItem:@"刷新数据" titleColor:nil clickBlock:^{
        STRONGSELF
        NSArray *idTypeArr = @[@{@"dcbbs":@"摄影"}, @{@"sjbbs":@"手机"},
                               @{@"nbbbs":@"电脑"}, @{@"朋友圈":@""},
                               @{@"otherbbs":@"家电"}, @{@"diybbs":@"硬件"}];
        NSDictionary *dic = idTypeArr[(arc4random() % idTypeArr.count)];
        NSString *typeTitle = dic.allValues[0];
        if (typeTitle.length>0) {
            strongSelf.title = typeTitle;
            strongSelf.bbsid = dic.allKeys[0];
        } else {
            strongSelf.bbsid = nil;
            strongSelf.title = @"朋友圈";
        }
        [strongSelf.plainTableView.mj_header beginRefreshing];
    }];
}

/**
 * 自定义表格DataSource类
 */
- (OKTableDelegateOrDataSource *)tableDelegateAndDataSource
{
    if(!_tableDelegateAndDataSource){
        WEAKSELF
        _tableDelegateAndDataSource = [OKTableDelegateOrDataSource createWithCellClass:[TimeLineCell class] isXibCell:YES configureCellBlock:nil];

        //获取UITableViewStylePlain表格所有row数据源
        [_tableDelegateAndDataSource setPlainTabDataArrBlcok:^NSArray* (){
            STRONGSELF
            return strongSelf.tableDataArr;
        }];
        
        //cell行高
        [_tableDelegateAndDataSource setHeightForRowBlcok:^CGFloat(id rowData, NSIndexPath *indexPath){
            return ((TimeLineDataModel *)rowData).cellHeight;
        }];
        
        //点击Cell回调
        [_tableDelegateAndDataSource setDidSelectRowBlcok:^(id rowData, NSIndexPath *indexPath){
            STRONGSELF
            TimeLineDataModel *model = rowData;
            NSString *urlString = [NSString stringWithFormat:@"http://m.zol.com.cn/%@/d%@_%@.html",model.post.bbs,model.post.boardId,model.post.bookId];
            [strongSelf pushToViewController:@"OKBaseWebViewController" propertyDic:@{@"urlString":urlString,@"title":model.post.title}];
        }];
    }
    return _tableDelegateAndDataSource;
}

/**
 *  请求表格数据
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
    if (self.bbsid.length>0) {
        info[@"bbsid"] = self.bbsid;
    }
    self.params = info;
    
    OKHttpRequestModel *model = [OKHttpRequestModel new];
    model.requestType = HttpRequestTypeGET;
    model.requestUrl = Url_DocList;
    model.parameters = info;
//    model.dataTableView = self.plainTableView;//sendExtensionRequest
    
    [OKHttpRequestTools sendOKRequest:model success:^(id returnValue) {
        [self refreshUIByData:returnValue parameters:info isFirst:firstPage];
        
    } failure:^(NSError *error) {
        //为什么在错误回调用调用刷新数据方法,因为底层判断请求失败的key在Demo上不统一
        if (error.userInfo[@"postList"]) {
            [self refreshUIByData:error.userInfo parameters:info isFirst:firstPage];
        } else {
            [self refreshUIByData:error parameters:info isFirst:firstPage];
        }
    }];
}

/**
 * 刷新UI
 */
- (void)refreshUIByData:(id)returnValue parameters:(NSDictionary *)info isFirst:(BOOL)firstPage
{
    if ([returnValue isKindOfClass:[NSError class]]) { //成功
        
        if (!firstPage) self.pageNum --;
        [self.plainTableView showRequestTip:returnValue];
        if (self.tableDataArr.count>0) {
            showAlertToastByError(returnValue, RequestFailCommomTip);
        }
        
    } else if ([returnValue isKindOfClass:[NSDictionary class]]) { //失败
        if (self.params != info) return;
        if (firstPage) {
            [self.tableDataArr removeAllObjects];
        }
        //包装数据
        [self convertData:returnValue];
        
        //设置数据分页标识
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:returnValue];
        dic[kTotalPageKey] = @"100";//总页数
        dic[kCurrentPageKey] = @(self.pageNum);//当前页数
        [self.plainTableView showRequestTip:dic];
    }
}

/**
 *  转换数据
 */
- (void)convertData:(NSDictionary *)dataDic
{
    NSMutableArray<TimeLineDataModel *> *modelArr = [TimeLineDataModel mj_objectArrayWithKeyValuesArray:dataDic[@"postList"]];
    [modelArr makeObjectsPerformSelector:@selector(calculateCellHeight)];//计算每个模型cell的高度
    [self.tableDataArr addObjectsFromArray:modelArr];
    [self.plainTableView reloadData];
}

@end
