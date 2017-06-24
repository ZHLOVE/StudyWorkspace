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
#define AgainRequestTipString                       @"重新加载"
#define kTotalPageKey                               @"totalPage"
#define kCurrentPageKey                             @"currentPage"
#define kListKey                                    @"list"

/*  弱引用 */
#define WEAKSELF                                    typeof(self) __weak weakSelf = self;
/*  强引用 */
#define STRONGSELF                                  typeof(weakSelf) __strong strongSelf = weakSelf;

static char const * const kFooterTipStringKey       = "kFooterTipStringKey";
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

#pragma mark - ========== UItableView"没有更多数据"提示 ==========

- (void)setFooterTipString:(NSString *)footerTipString
{
    objc_setAssociatedObject(self, kFooterTipStringKey, footerTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)footerTipString
{
    return objc_getAssociatedObject(self, kFooterTipStringKey);
}

#pragma mark - ========== 请求空数据提示 ==========

- (void)setReqEmptyTipString:(NSString *)reqEmptyTipString
{
    objc_setAssociatedObject(self, kReqEmptyTipStringKey, reqEmptyTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reqEmptyTipString
{
    NSString *emptyTip = objc_getAssociatedObject(self, kReqEmptyTipStringKey);
    return emptyTip ? : @"暂无数据";
}

#pragma mark - ========== 请求空数据图片 ==========

- (void)setReqEmptyTipImage:(UIImage *)reqEmptyTipImage
{
    objc_setAssociatedObject(self, kReqEmptyTipImageKey, reqEmptyTipImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)reqEmptyTipImage
{
    UIImage *image = objc_getAssociatedObject(self, kReqEmptyTipImageKey);
    if (!image) {
        image = [self getBundleImageByName:@"commonImage.bundle/empty_data_icon"];
    }
    return image;
}

#pragma mark - ========== 请求失败提示 ==========

- (void)setReqFailTipString:(NSString *)reqFailTipString
{
    objc_setAssociatedObject(self, kReqFailTipStringKey, reqFailTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)reqFailTipString
{
    NSString *tipStr = objc_getAssociatedObject(self, kReqFailTipStringKey);
    return tipStr ? : @"加载失败了哦!";
}

#pragma mark - ========== 请求失败图片 ==========

- (void)setReqFailTipImage:(UIImage *)reqFailTipImage
{
    objc_setAssociatedObject(self, kReqFailTipImageKey, reqFailTipImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)reqFailTipImage
{
    UIImage *image = objc_getAssociatedObject(self, kReqFailTipImageKey);
    if (!image) {
        image = [self getBundleImageByName:@"commonImage.bundle/loading_fail_icon"];
    }
    return image;
}

#pragma mark - ========== 网络错误提示 ==========

- (void)setNetErrorTipString:(NSString *)netErrorTipString
{
    objc_setAssociatedObject(self, kNetErrorTipStringKey, netErrorTipString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)netErrorTipString
{
    NSString *tipStr = objc_getAssociatedObject(self, kNetErrorTipStringKey);
    return tipStr ? : NetworkConnectFailTips;
}

#pragma mark - ========== 网络错误图片 ==========

- (void)setNetErrorTipImage:(UIImage *)netErrorTipImage
{
    objc_setAssociatedObject(self, kNetErrorTipImageKey, netErrorTipImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)netErrorTipImage
{
    UIImage *image = objc_getAssociatedObject(self, kNetErrorTipImageKey);
    if (!image) {
        image = [self getBundleImageByName:@"commonImage.bundle/networkfail_icon"];
    }
    return image;
}

#pragma mark - ========== 按钮点击的Target ==========

- (void)setEmptyDataBtnTitle:(NSString *)emptyDataBtnTitle
{
    objc_setAssociatedObject(self, kActionBtnTitleKey, emptyDataBtnTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)emptyDataBtnTitle
{
    return objc_getAssociatedObject(self, kActionBtnTitleKey);
}

#pragma mark - ========== 按钮点击的Target ==========

- (void)setEmptyDataActionTarget:(id)emptyDataActionTarget
{
    objc_setAssociatedObject(self, kActionTargetKey, emptyDataActionTarget, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)emptyDataActionTarget
{
    return objc_getAssociatedObject(self, kActionTargetKey);
}

#pragma mark - ========== 按钮点击的事件 ==========

- (void)setEmptyDataActionSEL:(SEL)emptyDataActionSEL
{
    NSString *selString = NSStringFromSelector(emptyDataActionSEL);
    objc_setAssociatedObject(self, kActionSELKey, selString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SEL)emptyDataActionSEL
{
    NSString *selString = objc_getAssociatedObject(self, kActionSELKey);
    return NSSelectorFromString(selString);
}

/**
 *  获取NSBundle里的提示图片资源
 */
- (UIImage *)getBundleImageByName:(NSString *)name
{
    return [UIImage imageNamed:name
                      inBundle:[NSBundle bundleForClass:[OKCommonTipView class]]
 compatibleWithTraitCollection:nil];
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
            
            WEAKSELF
            //根据状态,显示背景提示Viwe
            if (![AFNetworkReachabilityManager sharedManager].reachable) {//没有网络
                [self showTipWithStatus:RequesNoNetWorkStatus
                              tipString:self.netErrorTipString
                               tipImage:self.netErrorTipImage
                            actionTitle:AgainRequestTipString
                             clickBlock:^{
                                 STRONGSELF
                                 //移除提示视图,重新请求
                                 [strongSelf removeTipViewAndRefresh];
                             }];
                
            } else {//空数据提示
                [self showTipWithStatus:RequestEmptyDataStatus
                              tipString:self.reqEmptyTipString
                               tipImage:self.reqEmptyTipImage
                            actionTitle:self.emptyDataBtnTitle
                             clickBlock:^{
                                 STRONGSELF
                                 //如果额外设置了按钮事件
                                 if (strongSelf.emptyDataBtnTitle &&
                                     strongSelf.emptyDataActionTarget &&
                                     [strongSelf.emptyDataActionTarget respondsToSelector:strongSelf.emptyDataActionSEL]) {
                                     
                                     //1. 先移除页面上已有的提示视图
                                     [strongSelf removeOldTipBgView];
                                     
                                     //2. 重新添加按钮事件
                                     OKPerformSelectorLeakWarning(
                                         [strongSelf.emptyDataActionTarget performSelector:strongSelf.emptyDataActionSEL];
                                     );
                                 }
                             }];
            }
            
        } else { //页面有数据
            
            //移除页面上已有的提示视图
            [self removeOldTipBgView];
            
            if (self.mj_footer) {
                //控制刷新控件显示的分页逻辑
                [self setPageRefreshStatus:responseData];
            };
        }
        
    } else if([responseData isKindOfClass:[NSError class]]){ //请求失败处理
        if ([self contentViewIsEmptyData]) {//页面没有数据
            WEAKSELF
            //根据状态,显示背景提示Viwe
            if (![AFNetworkReachabilityManager sharedManager].reachable) { //没有网络提示
                [self showTipWithStatus:RequesNoNetWorkStatus
                              tipString:self.netErrorTipString
                               tipImage:self.netErrorTipImage
                            actionTitle:AgainRequestTipString
                             clickBlock:^{
                                 STRONGSELF
                                 //移除提示视图,重新请求
                                 [strongSelf removeTipViewAndRefresh];
                             }];
                
            } else {//请求失败提示
                [self showTipWithStatus:RequestFailStatus
                              tipString:self.reqFailTipString
                               tipImage:self.reqFailTipImage
                            actionTitle:AgainRequestTipString
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
 * 控制刷新控件显示的分页逻辑
 */
- (void)setPageRefreshStatus:(NSDictionary *)responseData
{
    id totalPage = responseData[kTotalPageKey];
    id currentPage = responseData[kCurrentPageKey];
    NSArray *dataArr = responseData[kListKey];
    
    if (totalPage && currentPage) {
        
        if ([totalPage integerValue] > [currentPage integerValue]) {
            self.mj_footer.hidden = NO;
            
            //是否显示表格的FooterView
            [self showTableFootView:NO];
            
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = YES;
            
            //是否显示表格的FooterView
            [self showTableFootView:YES];
        }
        
    } else if([dataArr isKindOfClass:[NSArray class]]){
        if (dataArr.count>0) {
            self.mj_footer.hidden = NO;
            
            //是否显示表格的FooterView
            [self showTableFootView:NO];
            
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
            self.mj_footer.hidden = YES;
            
            //是否显示表格的FooterView
            [self showTableFootView:YES];
        }
        
    } else {
        self.mj_footer.hidden = NO;
        
        //是否显示表格的FooterView
        [self showTableFootView:NO];
    }
}

/**
 *  是否显示表格的FooterView
 */
- (void)showTableFootView:(BOOL)show
{
    if (self.footerTipString && [self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        if (show) {
            UILabel *tipLabel = [[UILabel alloc] init];
            tipLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 50);
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.textColor = [UIColor lightGrayColor];
            tipLabel.text = [NSString stringWithFormat:@"----• %@ •----",self.footerTipString];
            tipLabel.font = [UIFont systemFontOfSize:14];
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tableView.tableFooterView = tipLabel;
        } else {
            tableView.tableFooterView = [UIView new];
        }
    }
}

#pragma mark - 如果请求失败,无网络则展示空白提示view

/**
 * 设置提示图片和文字
 */
- (void)showTipWithStatus:(TableVieTipStatus)state
                tipString:(NSString *)tipString
                 tipImage:(UIImage *)tipImage
              actionTitle:(NSString *)actionTitle
               clickBlock:(void(^)())block
{
    //先移除页面上已有的提示视图
    [self removeOldTipBgView];
    
    //需要显示的自定义提示view
    OKCommonTipView *tipBgView = [OKCommonTipView tipViewByFrame:self.bounds
                                                        tipImage:tipImage
                                                         tipText:tipString
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
            UIViewController *webViewVC = (UIViewController *)rsp;
            
            //获取控制器中的webview
            for (UIView *tempView in webViewVC.view.subviews) {
                if ([tempView isKindOfClass:[UIWebView class]]) {
                    
                    if ([tempView respondsToSelector:@selector(reload)]) {
                        NSLog(@"webview执行重新加载");
                        
                        //1.先移除页面上已有的提示视图
                        [self removeOldTipBgView];
                        
                        //2.执行webview的reload方法
                        OKPerformSelectorLeakWarning(
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

@end
