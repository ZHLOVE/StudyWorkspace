//
//  TimeLineVC.m
//  TimeLineDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "TimeLineVC.h"
#import "TableCell.h"
#import "TableViewModel.h"
#import <OKPubilcKeyDefiner.h>
#import "OKHttpRequestTools+OKExtension.h"
#import <NSDictionary+OKExtension.h>

//请求数据地址
#define Url_DocList     @"http://direct.wap.zol.com.cn/bbs/getRecommendBook.php?bbsid=dcbbs&ssid=%242a%2407%24403c8f4a8f512e730e163b7ad3d6b3123e6d5c15525674a76080dbb7f8cacc42&v=3.0&vs=iph561";

static NSString *const kTableCellID = @"cellIdInfo";

@interface TimeLineVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation TimeLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.plainTableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kTableCellID];
    
    WEAKSELF
    [self.plainTableView addheaderRefresh:^{
        [weakSelf requestData:YES];
    } footerBlock:^{
        [weakSelf requestData:NO];
    }];
    
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
        [returnValue printPropertyWithClassName:@"DataModel"];
        
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
    TableDataModel *model = [TableDataModel new];
    [model setValuesForKeysWithDictionary:dataDic];
    
    [self.tableDataArr addObjectsFromArray:model.postList];
    [self.plainTableView reloadData];
}

#pragma mark - /*** UITaleviewDelegate ***/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableDataModel *model = self.tableDataArr[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellID];
    cell.dataModel = self.tableDataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
