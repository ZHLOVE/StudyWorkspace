//
//  OKBaseWebViewController.m
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKBaseWebViewController.h"
#import <OKFrameDefiner.h>
#import "UIWebView+AFNetworking.h"
#import <OKPubilcKeyDefiner.h>
#import <OKCommonTipView.h>
#import "OKCFunction.h"
#import "UIScrollView+OKRequestExtension.h"
#import <UIViewController+OKExtension.h>
#import <UIBarButtonItem+OKExtension.h>

@interface OKBaseWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation OKBaseWebViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.webView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scrollView.customActionTarget = self;
    self.webView.scrollView.customActionSEL = @selector(loadWebViewData);

    //设配iOS11
    if (@available(iOS 11.0, *)) {
        self.htmlWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //加载Webview
    [self loadWebViewData];
}

#pragma mark ---------------导航按钮---------------

/**
 *  根据web判断是否添加返回和关闭按钮
 */
- (void)convertAddNavLeftItem
{
    UIImage *backImage = [UIImage imageNamed:@"commonImage.bundle/backBarButtonItemImage" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    UIBarButtonItem *item0 = [UIBarButtonItem itemWithImage:backImage highImage:nil target:self action:@selector(backBtnClick:)];
    
    if (self.webView.canGoBack) {
        UIImage *closeImage = [UIImage imageNamed:@"commonImage.bundle/close_nav_icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        
        UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:closeImage highImage:nil target:self action:@selector(closeBtnAction)];
        
        self.navigationItem.leftBarButtonItems = @[item0, item1];
        
    } else {
        self.navigationItem.leftBarButtonItem = item0;
    }
}

/**
 返回按钮事件
 */
- (void)backBtnClick:(UIButton *)sender
{
    [self judgeLeftBarItemBackAction];
}

/**
 *  判断导航左边按钮能否否能返回
 */
- (void)judgeLeftBarItemBackAction
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self closeBtnAction];
    }
}

/**
 *  关闭按钮事件
 */
- (void)closeBtnAction
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setRightBtnImage:(UIImage *)rightBtnImage
{
    _rightBtnImage = rightBtnImage;
    
    if (rightBtnImage) {
        WEAKSELF
        [self addRightBarButtonItem:rightBtnImage
                          highImage:nil
                         clickBlock:^{
                             if (weakSelf.rightBtnBlock) {
                                 weakSelf.rightBtnBlock();
                             }
                         }];
    }
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle
{
    _rightBtnTitle = rightBtnTitle;
    
    if (rightBtnTitle) {
        WEAKSELF
        [self addRightBarButtonItem:rightBtnTitle
                         titleColor:nil
                         clickBlock:^{
                             if (weakSelf.rightBtnBlock) {
                                 weakSelf.rightBtnBlock();
                             }
                         }];
    }
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

/**
 *  加载Webview
 */
- (void)loadWebViewData
{
    if (!self.urlString) {
        [self.webView.scrollView showRequestTip:DefaultRequestError];
        return;
    }
    
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

#pragma mark ---------------UIWebViewDelegate---------------

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showLoadingToView:self.view text:@"拼命加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideLoadingFromView:self.view];
    
    [self convertAddNavLeftItem];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideLoadingFromView:self.view];
    
    [self convertAddNavLeftItem];
    
    [self.webView.scrollView showRequestTip:error];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
