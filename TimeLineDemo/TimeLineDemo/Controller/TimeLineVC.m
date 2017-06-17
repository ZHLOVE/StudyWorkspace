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
#import <NSDictionary+OKExtension.h>
#import <MJExtension.h>
#import <UIViewController+OKExtension.h>
#import <MJRefresh.h>

//请求数据地址
#define Url_DocList  @"http://direct.wap.zol.com.cn/bbs/getRecommendBook.php?ssid=%242a%2407%24403c8f4a8f512e730e163b7ad3d6b3123e6d5c15525674a76080dbb7f8cacc42&v=3.0&vs=iph561"


static NSString *const kTableCellID = @"cellIdInfo";

@interface TimeLineVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *bbsid;
@end

@implementation TimeLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.plainTableView registerNib:[UINib nibWithNibName:@"TimeLineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kTableCellID];
    
    WEAKSELF
    [self.plainTableView addheaderRefresh:^{
        [weakSelf requestData:YES];
    } footerBlock:^{
        [weakSelf requestData:NO];
    }];
    
    //刷新数据
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新数据" style:UIBarButtonItemStylePlain target:self action:@selector(refreshData)];
}

/**
 *  刷新数据
 */
- (void)refreshData
{
    NSArray *idTypeArr = @[@{@"dcbbs":@"摄影"},
                            @{@"sjbbs":@"手机"},
                            @{@"nbbbs":@"电脑"},
                            @{@"otherbbs":@"家电"},
                            @{@"diybbs":@"硬件"}];
    NSDictionary *dic = idTypeArr[arc4random() % idTypeArr.count];
    self.bbsid = dic.allKeys[0];
    NSString *typeTitle = dic.allValues[0];
    self.title = [NSString stringWithFormat:@"朋友圈-<%@>",typeTitle];
    
    [self.plainTableView.mj_header beginRefreshing];
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
    
    OKHttpRequestModel *model = [[OKHttpRequestModel alloc] init];
    model.requestType = HttpRequestTypeGET;
    model.requestUrl = Url_DocList;
    model.parameters = info;
    
    //model.loadView = self.view;
    model.dataTableView = self.plainTableView;
    
    [OKHttpRequestTools sendExtensionRequest:model success:^(id returnValue) {
        if (self.params != info) return;
        if (firstPage) {
            [self.tableDataArr removeAllObjects];
        }
//        [returnValue printPropertyWithClassName:@"DataModel"];
        
        //包装数据
        [self convertData:returnValue];
        
    } failure:^(NSError *error) {
        if (!firstPage) self.pageNum --;
    }];
}

/**
 *  转换数据
 */
- (void)convertData:(NSDictionary *)dataDic
{
    NSMutableArray<TimeLineDataModel *> *modelArr = [TimeLineDataModel mj_objectArrayWithKeyValuesArray:dataDic[@"postList"]];
    //计算每个模型cell的高度
    [modelArr makeObjectsPerformSelector:@selector(calculateCellHeight)];
    [self.tableDataArr addObjectsFromArray:modelArr];
    [self.plainTableView reloadData];
}

#pragma mark - /*** UITaleviewDelegate ***/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineDataModel *model = self.tableDataArr[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellID];
    cell.dataModel = self.tableDataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TimeLineDataModel *model = self.tableDataArr[indexPath.row];
    NSString *urlString = [NSString stringWithFormat:@"http://m.zol.com.cn/%@/d%@_%@.html",
                           model.post.bbs,
                           model.post.boardId,
                           model.post.bookId];
    [self pushToViewController:@"TimeLineWebVC"
                   propertyDic:@{@"urlString":urlString,@"title":model.post.title}];
}


@end
