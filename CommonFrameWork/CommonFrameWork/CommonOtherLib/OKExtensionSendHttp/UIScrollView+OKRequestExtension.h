//
//  UIScrollView+OKRequestExtension.h
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/17.
//  Copyright © 2017年 OKDeer. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 进入刷新状态的回调 */
typedef void (^OKRefreshingBlock)();

typedef enum : NSUInteger {
    RequestNormalStatus,    //0 正常状态
    RequestEmptyDataStatus, //1 空数据
    RequestFailStatus,      //2 加载失败
    RequesErrorNoNetWork,   //3 网络连接失败
} TableVieTipStatus;


@interface UIScrollView (OKRequestExtension)

/** 空数据提示 */
@property (nonatomic, strong) NSString *reqEmptyTipString;

/** 空数据提示图片 */
@property (nonatomic, strong) UIImage *reqEmptyTipImage;

/** 请求失败提示 */
@property (nonatomic, strong) NSString *reqFailTipString;

/** 请求失败提示图片 */
@property (nonatomic, strong) UIImage *reqFailTipImage;

/** 网络连接失败提示 */
@property (nonatomic, strong) NSString *netErrorTipString;

/** 网络连接失败图片 */
@property (nonatomic, strong) UIImage *netErrorTipImage;

/** 按钮标题 */
@property (nonatomic, strong) NSString *actionBtnTitle;

/** 按钮点击的Target */
@property (nonatomic, strong) id actionTarget;

/** 按钮点击的事件 */
@property (nonatomic, assign) SEL actionSEL;


#pragma mark - 给表格添加上下拉刷新事件

/**
 初始化表格的上下拉刷新控件
 
 @param headerBlock 下拉刷新需要调用的函数
 @param footerBlock 上啦刷新需要调用的函数
 */
- (void)addheaderRefresh:(OKRefreshingBlock)headerBlock
             footerBlock:(OKRefreshingBlock)footerBlock;

/**
 * 设置提示图片和文字
 */
- (void)showTipBotton:(BOOL)show
            TipStatus:(TableVieTipStatus)state
            tipString:(NSString *)tipString
           clickBlock:(void(^)())blk;


#pragma mark - 处理表格上下拉刷新,分页,添加空白页事件

/**
 调用此方法,会自动处理表格上下拉刷新,分页,添加空白页等操作
 
 @param responseData 网络请求回调数据 (NSDictionary,NSError)
 */
- (void)showRequestTip:(id)responseData;


@end
