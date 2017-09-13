//
//  WebViewController.m
//  MutableTargetDemo
//
//  Created by Luke on 2017/9/13.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *loadingBtn;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //加载webView
    [self loadingWebView];
}

/**
 *  加载webView
 */
- (IBAction)loadingWebView
{
    [self.activityView startAnimating];
    
    NSString *path= @"http://fir.im/vlpc";
    NSURL*url = [NSURL URLWithString:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark ---------------UIWebViewDelegate---------------

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadingBtn.enabled = NO;
    self.loadingBtn.hidden = NO;
    [self.loadingBtn setTitle:@"拼命加载中..." forState:UIControlStateDisabled];
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.loadingBtn.hidden = YES;
    self.loadingBtn.enabled = YES;
    [self.activityView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.loadingBtn.enabled = YES;
    self.loadingBtn.hidden = NO;
    [self.loadingBtn setTitle:@"页面加载失败,请重试" forState:0];
    [self.activityView stopAnimating];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
