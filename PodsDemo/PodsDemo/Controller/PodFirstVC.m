//
//  FirstViewController.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PodFirstVC.h"
#import "OKReachabilityManager.h"
#import <OKAlertView.h>
#import "PodSendReqVC.h"

//发送封装多功能请求用到
#import "OKHttpRequestTools+OKExtension.h"
//发送普通请求用到
#import "OKHttpRequestTools.h"

#define TestRequestUrl1      @"http://api.cnez.info/product/getProductList/1"
#define TestRequestUrl2      @"http://lib3.wap.zol.com.cn/index.php?c=Advanced_List_V1&keyword=808.8GB%205400%E8%BD%AC%2032MB&noParam=1&priceId=noPrice&num=1"

@interface PodFirstVC ()
@end

@implementation PodFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [OKReachabilityManager reachabilityChangeBlock:^(AFNetworkReachabilityStatus currentStatus, AFNetworkReachabilityStatus lastReachabilityStatus) {
        
        NSLog(@"监听网络改变回调===%zd===%zd",currentStatus,lastReachabilityStatus);
    }];
}


/**
 列表请求
 */
- (IBAction)sendHttpReqAction:(id)sender
{
    PodSendReqVC *demoVC = [[PodSendReqVC alloc] init];
    demoVC.title = @"测试表格分页请求";
    demoVC.hidesBottomBarWhenPushed = YES;
    demoVC.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:demoVC animated:YES];
}

/**
 普通请求
 */
- (IBAction)sendHttpReq:(id)sender
{
    //    //测试同时发送50个请求, 底层会自动管理
    //    for (int i=0; i<20; i++) {
    //
    //        //测试发送普通请求
    //        [self sendCommomReq];
    //
    //        //测试发送封装多功能请求
    //        //[self sendMultifunctionReq:i];
    //    }
    
    //    //测试发送普通请求
//    [self sendCommomReq];
    //    //测试发送普通请求
        [self sendMultifunctionReq:0];
}

/**
 * 发送封装多功能请求
 */
- (void)sendMultifunctionReq:(int)tag
{
    OKHttpRequestModel *model = [[OKHttpRequestModel alloc] init];
    model.requestType = HttpRequestTypeGET;
    model.parameters = nil;
    model.requestUrl = TestRequestUrl2;
    
    model.loadView = self.view;
    //model.dataTableView = self.tableView;//如果页面有表格可传入会自动处理很多事件
    //model.sessionDataTaskArr = self.sessionDataTaskArr; //传入,则自动管理取消请求的操作
    //model.requestCachePolicy = RequestStoreCacheData; //需要保存底层网络数据
    
    NSURLSessionDataTask *task = [OKHttpRequestTools sendExtensionRequest:model success:^(id returnValue) {
        ShowAlertToast(@"请求成功,请查看打印日志");
        
    } failure:^(NSError *error) {
        ShowAlertToast(@" 悲剧哦, 请求失败了");
    }];
    
    NSLog(@"发送请求中===%zd===%@",tag,task);
    
    //    if (tag == 49) {
    //        NSLog(@"取消所有请求后, 底层不会回调成功或失败到页面上来");
    //        [self cancelRequestOperations];
    //    }
}

/**
 * 发送普通请求
 */
- (void)sendCommomReq
{
    OKHttpRequestModel *model = [[OKHttpRequestModel alloc] init];
    model.requestType = HttpRequestTypeGET;
    model.parameters = nil;
    model.requestUrl = TestRequestUrl1;
    
    NSURLSessionDataTask *task = [OKHttpRequestTools sendOKRequest:model success:^(id returnValue) {
        ShowAlertToast(@"请求成功,请查看打印日志");
        
    } failure:^(NSError *error) {
        ShowAlertToast(@" 悲剧哦, 请求失败了");
    }];
    
    NSLog(@"测试发送普通请求===%@",task);
}

@end

