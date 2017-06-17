//
//  TimeLineWebVC.m
//  TimeLineDemo
//
//  Created by Luke on 2017/6/18.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "TimeLineWebVC.h"
#import <OKFrameDefiner.h>
#import "UIWebView+AFNetworking.h"
#import <OKPubilcKeyDefiner.h>
#import <OKCommonTipView.h>

@interface TimeLineWebVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIView *errorTipView;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation TimeLineWebVC


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.webView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
        _webView.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadWebViewData];
}

/**
 *  加载Webview
 */
- (void)loadWebViewData
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:(self.urlString)]];
    request.timeoutInterval = 30;
    
    WEAKSELF
    NSProgress *progress;
    [self.webView loadRequest:request progress:&progress success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
        NSString *title = [weakSelf.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if (title.length>0) {
            weakSelf.title = title;
        }
        return HTML;
    } failure:nil];
}

#pragma mark - UIWebViewDelegate

- (void)shareBtnAction
{
    //显示分享框
//    if (self.shareModel) {
//        [CNShareActionView showShareViewWithTitle:self.shareModel.shareTitle shareModel:self.shareModel comeFromType:ShareComeFromGoodsManager];
//    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showLoadingToView:self.view text:@"正在加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideLoadingFromView:self.view];
    
//    if (self.shareModel) {
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_share" highImage:nil target:self action:@selector(shareBtnAction)];
//    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideLoadingFromView:self.view];
    
    UIButton *errorTipView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    errorTipView.center = self.view.center;
    [errorTipView setTitle:@"加载失败，点击重试" forState:0];
    [errorTipView addTarget:self action:@selector(reloadWebView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.webView addSubview:errorTipView];
    self.errorTipView = errorTipView;
}

#pragma mark - 重新加载

- (void)reloadWebView
{
    [self.errorTipView removeFromSuperview];
    self.errorTipView = nil;
    [self.webView reload];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

