//
//  UITableView+OKExtension.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/6/13.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UITableView+OKExtension.h"
#import <objc/runtime.h>

static char const * const kAutomaticShowTipViewKey    = "kAutomaticShowTipViewKey";

@implementation UITableView (OKExtension)

/**
 *  交换两个实例方法的实现
 *
 *  @param class          类名
 *  @param originSelector 原始方法
 *  @param otherSelector  需要覆盖原始的方法
 */
+ (void)ok_exchangeInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+(void)initialize
{
    //交换刷新表格方法
    [self ok_exchangeInstanceMethod:[self class]
                     originSelector:@selector(reloadData)
                      otherSelector:@selector(ok_reloadData)];
    //交换删除表格方法
    [self ok_exchangeInstanceMethod:[self class]
                     originSelector:@selector(deleteRowsAtIndexPaths:withRowAnimation:)
                      otherSelector:@selector(ok_deleteRowsAtIndexPaths:withRowAnimation:)];
    //交换刷新表格Sections方法
    [self ok_exchangeInstanceMethod:[self class]
                     originSelector:@selector(reloadSections:withRowAnimation:)
                      otherSelector:@selector(ok_reloadSections:withRowAnimation:)];
}


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

#pragma mark - ========== 替换系统刷新表格的方法 ==========

/**
 * 交换刷新表格方法
 */
- (void)ok_reloadData
{
    NSLog(@"交换表格系统刷新方法");
    [self ok_reloadData];
    
    //是否显示自定义提示view
    [self convertShowTipView];
}

/**
 * 交换删除表格方法
 */
- (void)ok_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                 withRowAnimation:(UITableViewRowAnimation)animation
{
    NSLog(@"交换删除表格方法");
    [self ok_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    //是否显示自定义提示view
    [self convertShowTipView];
}

/**
 * 交换刷新表格Sections方法
 */
- (void)ok_reloadSections:(NSIndexSet *)sections
         withRowAnimation:(UITableViewRowAnimation)animation
{
    NSLog(@"交换刷新表格Sections方法");
    [self ok_reloadSections:sections withRowAnimation:animation];
    
    //是否显示自定义提示view
    [self convertShowTipView];
}

#pragma mark - ========== 处理自动根据表格数据来显示提示view ==========

/**
 *  是否显示自定义提示view
 */
- (void)convertShowTipView
{
    //需要显示提示view
    if (self.automaticShowTipView) {
        
        //给表格添加上请求失败提示事件
        [self showRequestTip:[NSDictionary new]];
    }
}

@end
