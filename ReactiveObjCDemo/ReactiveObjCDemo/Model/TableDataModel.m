//
//  TableDataModel.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "TableDataModel.h"
#import "OKHttpRequestTools+OKExtension.h"
#import <OKAlertView.h>

//数据请求地址
#define KrequestPathUrl     @"https://api.douban.com/v2/book/search"

@implementation TableDataModel

@end

@implementation RequestViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

- (void)initialBind
{
    @weakify(self)
    _reuqesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            
//            kRequestCodeKey = @"start";
            OKHttpRequestModel *model = [OKHttpRequestModel new];
            model.parameters = @{@"q":@"基础"};
            model.requestUrl = KrequestPathUrl;
            model.requestType = HttpRequestTypeGET;
            model.dataTableView = self.tableView;
            model.loadView = self.vcView;
            [OKHttpRequestTools sendExtensionRequest:model success:^(id returnValue) {
                // 请求成功调用
                
                // 把数据用信号传递出去
                [subscriber sendNext:returnValue];
                //结束发送订阅
                [subscriber sendCompleted];
                
            } failure:^(NSError *error) {
                showAlertToastByError(error, @"😔 请求失败了哦");
                
                //结束发送订阅
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            
            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                TableDataModel *model = [TableDataModel new];
                [model setValuesForKeysWithDictionary:value];
                return model;
            }] array];
            
            return modelArr;
        }];
    }];
    
    // 获取请求的数据
    [_reuqesCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *x) {
        @strongify(self)
        
        // 有了新数据，刷新表格
        _models = x;
        
        // 刷新表格
        [self.tableView reloadData];
    }];
}

#pragma mark -===========UITableViewDataSource===========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    TableDataModel *book = self.models[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    return cell;
}

@end
