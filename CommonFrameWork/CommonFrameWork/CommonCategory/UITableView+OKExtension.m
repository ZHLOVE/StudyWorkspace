//
//  UITableView+OKExtension.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/6/13.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UITableView+OKExtension.h"
#import <AFNetworkReachabilityManager.h>
#import "OKPubilcKeyDefiner.h"
#import "OKCommonTipView.h"
#import "NSObject+OKRuntime.h"
#import <objc/runtime.h>

static char const * const kAutomaticShowTipViewKey    = "kAutomaticShowTipViewKey";

@implementation UITableView (OKExtension)

#pragma mark - ========== 是否自动显示请求提示view ==========

- (void)setAutomaticShowTipView:(BOOL)automaticShowTipView
{
    objc_setAssociatedObject(self, kAutomaticShowTipViewKey, @(automaticShowTipView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)automaticShowTipView
{
    id value = objc_getAssociatedObject(self, kAutomaticShowTipViewKey);
    return [value boolValue];
}


+(void)initialize
{
    //交换表格刷新方法
    [self ok_exchangeInstanceMethod:[self class] originSelector:@selector(reloadData) otherSelector:@selector(ok_reloadData)];
}

/**
 * 交换表格刷新方法
 */
- (void)ok_reloadData
{
    NSLog(@"交换表格系统刷新方法");
    [self ok_reloadData];
    
    //需要显示提示view
    if (self.automaticShowTipView) {
        
        //显示自定义提示view
        [self showCustomRequest];
    }
}


#pragma mark - 给表格添加上请求失败提示事件

/**
 调用此方法,会自动处理表格上下拉刷新,分页,添加空白页等操作
 */
- (void)showCustomRequest
{
    if ([self contentViewIsEmptyData]) {//页面没有数据
        
        //根据状态,显示背景提示Viwe
        if (![AFNetworkReachabilityManager sharedManager].reachable) {//没有网络
            WEAKSELF
            [self showTipBotton:YES
                      TipStatus:RequesErrorNoNetWork
                      tipString:nil
                     clickBlock:^{
                         //先移提示视图,添加点击事件
                         [weakSelf setTipViewButtonAction];
                     }];
        } else {
            [self showTipBotton:YES
                      TipStatus:RequestEmptyDataStatus
                      tipString:nil
                     clickBlock:nil];
        }
    } else { //页面有数据
        //隐藏背景提示Viwe
        [self showTipBotton:NO
                  TipStatus:RequestNormalStatus
                  tipString:nil
                 clickBlock:nil];
    }
}

/**
 * 先移除页面上已有的提示视图,添加相应的点击事件
 */
- (void)setTipViewButtonAction
{
    for (UIView *tempView in self.superview.subviews) {
        if ([tempView isKindOfClass:[OKCommonTipView class]] ||
            tempView.tag == kRequestTipViewTag) {
            [tempView removeFromSuperview];
            break;
        }
    }
    
    if (self.actionTarget && [self.actionTarget respondsToSelector:self.actionSEL]) {
        OKPerformSelectorLeakWarning(
          [self.actionTarget performSelector:self.actionSEL];
      );
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
            return NO;
        } else {
            return YES;
        }
    }
    return isEmpty;
}

@end
