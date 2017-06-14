//
//  UIScrollView+OKRequestExtension.m
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/17.
//  Copyright © 2017年 OKDeer. All rights reserved.
//

#import "UIScrollView+OKRequestExtension.h"
#import <AFNetworkReachabilityManager.h>
#import "OKCommonTipView.h"
#import <MJRefresh.h>

/** 网络连接失败 */
#define NetworkConnectFailTips                      @"网络开小差, 请稍后再试哦!"
#define kTotalPageKey                               @"totalPage"
#define kCurrentPageKey                             @"currentPage"
#define kListKey                                    @"list"

/*  弱引用 */
#define WEAKSELF                                    typeof(self) __weak weakSelf = self;
/*  强引用 */
#define STRONGSELF                                  typeof(weakSelf) __strong strongSelf = weakSelf;

static char const * const kReqEmptyTipStringKey     = "kReqEmptyTipStringKey";
static char const * const kReqEmptyTipImageKey      = "kReqEmptyTipImageKey";
static char const * const kReqFailTipStringKey      = "kReqFailTipStringKey";
static char const * const kReqFailTipImageKey       = "kReqFailTipImageKey";
static char const * const kNetErrorTipStringKey     = "kNetErrorTipStringKey";
static char const * const kNetErrorTipImageKey      = "kNetErrorTipImageKey";
static char const * const kActionBtnTitleKey        = "kActionBtnTitleKey";
static char const * const kActionTargetKey          = "kActionTargetKey";
static char const * const kActionSELKey             = "kActionSELKey";


@implementation UIScrollView (OKRequestExtension)

#pragma mark - ========== 请求空数据提示 ==========

- (void)setReqEmptyTipString:(NSString *)reqEmptyTipString
{
    objc_setAssociatedObject(self, kReqEmptyTipStringKey, reqEmptyTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reqEmptyTipString
{
    return objc_getAssociatedObject(self, kReqEmptyTipStringKey);
}

#pragma mark - ========== 请求空数据图片 ==========

- (void)setReqEmptyTipImage:(UIImage *)reqEmptyTipImage
{
    objc_setAssociatedObject(self, kReqEmptyTipImageKey, reqEmptyTipImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reqEmptyTipImage
{
    return objc_getAssociatedObject(self, kReqEmptyTipImageKey);
}

#pragma mark - ========== 请求失败提示 ==========

- (void)setReqFailTipString:(NSString *)reqFailTipString
{
    objc_setAssociatedObject(self, kReqFailTipStringKey, reqFailTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reqFailTipString
{
    return objc_getAssociatedObject(self, kReqFailTipStringKey);
}

#pragma mark - ========== 请求失败图片 ==========

- (void)setReqFailTipImage:(UIImage *)reqFailTipImage
{
    objc_setAssociatedObject(self, kReqFailTipImageKey, reqFailTipImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reqFailTipImage
{
    return objc_getAssociatedObject(self, kReqFailTipImageKey);
}

#pragma mark - ========== 网络错误提示 ==========

- (void)setNetErrorTipString:(NSString *)netErrorTipString
{
    objc_setAssociatedObject(self, kNetErrorTipStringKey, netErrorTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)netErrorTipString
{
    return objc_getAssociatedObject(self, kNetErrorTipStringKey);
}

#pragma mark - ========== 网络错误图片 ==========

- (void)setNetErrorTipImage:(UIImage *)netErrorTipImage
{
    objc_setAssociatedObject(self, kNetErrorTipImageKey, netErrorTipImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)netErrorTipImage
{
    return objc_getAssociatedObject(self, kNetErrorTipImageKey);
}

#pragma mark - ========== 按钮点击的Target ==========

- (void)setActionBtnTitle:(NSString *)actionBtnTitle
{
    objc_setAssociatedObject(self, kActionBtnTitleKey, actionBtnTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)actionBtnTitle
{
    return objc_getAssociatedObject(self, kActionBtnTitleKey);
}

#pragma mark - ========== 按钮点击的Target ==========

- (void)setActionTarget:(id)actionTarget
{
    objc_setAssociatedObject(self, kActionTargetKey, actionTarget, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)actionTarget
{
    return objc_getAssociatedObject(self, kActionTargetKey);
}

#pragma mark - ========== 按钮点击的事件 ==========

- (void)setActionSEL:(SEL)actionSEL
{
    NSString *selString = NSStringFromSelector(actionSEL);
    objc_setAssociatedObject(self, kActionSELKey, selString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SEL)actionSEL
{
    NSString *selString = objc_getAssociatedObject(self, kActionSELKey);
    return NSSelectorFromString(selString);
}

/**
 * 开始监听网络
 */
+ (void)load
{
    //AFN需要提前监听网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - 给表格添加上下拉刷新事件

/**
 初始化表格的上下拉刷新控件
 
 @param headerBlock 下拉刷新需要调用的函数
 @param footerBlock 上啦刷新需要调用的函数
 */
- (void)addheaderRefresh:(OKRefreshingBlock)headerBlock footerBlock:(OKRefreshingBlock)footerBlock
{
    if (headerBlock) {
        WEAKSELF
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            STRONGSELF
            
            //1.先移除页面上已有的提示视图
            [strongSelf removeOldTipBgView];
            
            //2.每次下拉刷新时先结束上啦
            [strongSelf.mj_footer endRefreshing];
            
            headerBlock();
        }];
        [self.mj_header beginRefreshing];
    }
    
    if (footerBlock) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        //这里需要先隐藏,否则已进入页面没有数据也会显示上拉view
        self.mj_footer.hidden = YES;
    }
}

#pragma mark - 给表格添加上请求失败提示事件

/**
 调用此方法,会自动处理表格上下拉刷新,分页,添加空白页等操作
 
 @param responseData 网络请求回调数据
 */
- (void)showRequestTip:(id)responseData
{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
    
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
    
    //如果请求成功处理
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        if ([self contentViewIsEmptyData]) {//页面没有数据
            
            //根据状态,显示背景提示Viwe
            if (![AFNetworkReachabilityManager sharedManager].reachable) {//没有网络
                WEAKSELF
                [self showTipWithStatus:RequesErrorNoNetWork
                              tipString:nil
                             clickBlock:^{
                                 STRONGSELF
                                 //移除提示视图,重新请求
                                 [strongSelf removeTipViewAndRefresh];
                             }];
                
            } else {
                [self showTipWithStatus:RequestEmptyDataStatus
                              tipString:nil
                             clickBlock:nil];
            }
            
        } else { //页面有数据
            
            //移除页面上已有的提示视图
            [self removeOldTipBgView];
            
            if (self.mj_footer) {
                //控制刷新控件显示的分页逻辑
                [self setRefreshStatus:responseData];
            };
        }
        
    } else if([responseData isKindOfClass:[NSError class]]){ //请求失败处理
        NSError *error = (NSError *)responseData;
        if ([self contentViewIsEmptyData]) {//页面没有数据
            
            //根据状态,显示背景提示Viwe
            WEAKSELF
            if (![AFNetworkReachabilityManager sharedManager].reachable) { //没有网络
                
                [self showTipWithStatus:RequesErrorNoNetWork
                              tipString:NetworkConnectFailTips
                             clickBlock:^{
                                 STRONGSELF
                                 //移除提示视图,重新请求
                                 [strongSelf removeTipViewAndRefresh];
                             }];
                
            } else {
                [self showTipWithStatus:RequestFailStatus
                              tipString:error.domain
                             clickBlock:^{
                                 STRONGSELF
                                 //移除提示视图,重新请求
                                 [strongSelf removeTipViewAndRefresh];
                             }];
            }
        } else { //页面有数据
            
            //移除页面上已有的提示视图
            [self removeOldTipBgView];
        }
    }
}

/**
 * 判断页面是否有数据
 */
- (BOOL)contentViewIsEmptyData
{
    BOOL isEmpty = NO;
    
    //如果是UITableView
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        if (tableView.numberOfSections==0 ||
            (tableView.numberOfSections==1 && [tableView numberOfRowsInSection:0] == 0)) {
            isEmpty = YES;
        }
        
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        if (collectionView.numberOfSections==0 ||
            (collectionView.numberOfSections==1 && [collectionView numberOfItemsInSection:0] == 0)) {
            isEmpty = YES;
        }
    } else {
        if (self.hidden || self.alpha == 0) {
            isEmpty = NO;
        } else {
            isEmpty = YES;
        }
    }
    return isEmpty;
}

/**
 * 控制刷新控件显示的分页逻辑
 */
- (void)setRefreshStatus:(NSDictionary *)responseData
{
    id totalPage = responseData[kTotalPageKey];
    id currentPage = responseData[kCurrentPageKey];
    NSArray *dataArr = responseData[kListKey];
    
    if (totalPage && currentPage) {
        
        if ([totalPage integerValue] > [currentPage integerValue]) {
            self.mj_footer.hidden = NO;
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = YES;
        }
        
    } else if([dataArr isKindOfClass:[NSArray class]]){
        if (dataArr.count>0) {
            self.mj_footer.hidden = NO;
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = YES;
        }
        
    } else {
        self.mj_footer.hidden = NO;
    }
}

#pragma mark - 如果请求失败,无网络则展示空白提示view

/**
 * 设置提示图片和文字
 */
- (void)showTipWithStatus:(TableVieTipStatus)state
                tipString:(NSString *)errorTip
               clickBlock:(void(^)())block
{
    //先移除页面上已有的提示视图
    [self removeOldTipBgView];
    
    NSString *customTip = nil;
    UIImage *tipImage = nil;
    NSString *actionTitle = nil;
    
    //获取NSBundle里的图片资源
    UIImage *(^tipImageBlcok)(NSString *) = ^UIImage *(NSString *imgName){
        return [UIImage imageNamed:imgName
                          inBundle:[NSBundle bundleForClass:[OKCommonTipView class]]
     compatibleWithTraitCollection:nil];;
    };
    
    if (state == RequestNormalStatus) { //正常状态
        //不需要处理, 留给后面扩展
        
    } else if (state == RequestEmptyDataStatus) { //请求空数据
        customTip = self.reqEmptyTipString ? : @"暂无数据";
        tipImage = self.reqEmptyTipImage ? : tipImageBlcok(@"commonImage.bundle/empty_data_icon");
        
    } else if (state == RequesErrorNoNetWork) { //网络连接失败
        
        actionTitle = self.actionBtnTitle.length ? self.actionBtnTitle : @"重新加载";
        customTip = self.netErrorTipString ? : @"网络开小差, 请稍后再试哦!";
        tipImage = self.netErrorTipImage ? : tipImageBlcok(@"commonImage.bundle/networkfail_icon");
        
    } else if (state == RequestFailStatus) { //请求失败
        
        actionTitle = self.actionBtnTitle.length ? self.actionBtnTitle : @"重新加载";
        customTip = self.reqFailTipString ? : @"加载失败了哦!";
        tipImage = self.reqFailTipImage ? : tipImageBlcok(@"commonImage.bundle/loading_fail_icon");
    }
    
    customTip = errorTip.length>0 ? errorTip : customTip;
    
    //如果额外设置了按钮事件
    if (self.actionTarget && [self.actionTarget respondsToSelector:self.actionSEL]) {
        WEAKSELF
        block = ^(){
            STRONGSELF
            //1. 先移除页面上已有的提示视图
            [strongSelf removeOldTipBgView];
            
            //2. 重新添加按钮事件
            OKPerformSelectorLeakWarning(
                                         [strongSelf.actionTarget performSelector:strongSelf.actionSEL];
                                         );
        };
    }
    
    //需要显示的自定义提示view
    OKCommonTipView *tipBgView = [OKCommonTipView tipViewByFrame:self.bounds
                                                        tipImage:tipImage
                                                         tipText:customTip
                                                     actionTitle:actionTitle
                                                     actionBlock:block];
    tipBgView.backgroundColor = [UIColor clearColor];
    tipBgView.center = self.center;
    [self addSubview:tipBgView];
}

/**
 * 移除提示视图,重新请求
 */
- (void)removeTipViewAndRefresh
{
    if (self.mj_header) {
        //1.先移除页面上已有的提示视图
        [self removeOldTipBgView];
        
        //2.开始走下拉请求
        [self.mj_header beginRefreshing];
        
    } else {
        //兼容self为webView.scrollView是从这种方式的访问
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIResponder *rsp = self;
            while (![rsp isKindOfClass:[UIViewController class]]) {
                rsp = rsp.nextResponder;
            }
            //获取到webview所在的控制器
            UIViewController *superVC = (UIViewController *)rsp;
            
            //拿到控制器中的webview
            for (UIView *tempView in superVC.view.subviews) {
                if ([tempView isKindOfClass:[UIWebView class]]) {
                    
                    if ([tempView respondsToSelector:@selector(reload)]) {
                        NSLog(@"webview执行重新加载");
                        
                        //1.先移除页面上已有的提示视图
                        [self removeOldTipBgView];
                        
                        OKPerformSelectorLeakWarning(
                                                     //2.执行webview重新载入
                                                     [tempView performSelector:@selector(reload)];
                                                     );
                    }
                    break;
                }
            }
        }
    }
}

/**
 先移除页面上已有的提示视图
 */
- (void)removeOldTipBgView
{
    for (UIView *tempView in self.subviews) {
        if ([tempView isKindOfClass:[OKCommonTipView class]] ||
            tempView.tag == kRequestTipViewTag) {
            [tempView removeFromSuperview];
            break;
        }
    }
}

@end
