//
//  OKTableDelegateAndDataSource.h
//  OkdeerSeller
//
//  Created by mao wangxin on 2017/8/15.
//  Copyright © 2017年 Okdeer. All rights reserved.
//
//  Plain类型表格的Delegate和DataSource

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HeaderType,
    FooterType,
} SectionType;

typedef void (^TableViewCellConfigureBlock) (id cell, id rowData, NSIndexPath *indexPath);
typedef UIView * (^ViewForSectionBlcok)(SectionType sectionType,NSInteger section);
typedef CGFloat (^HeightForSectionBlcok)(SectionType sectionType,NSInteger section);
typedef CGFloat (^HeightForRowBlcok)(id rowData, NSIndexPath *indexPath);
typedef NSArray* (^GroupTabDataOfSections)(NSInteger section);
typedef NSInteger (^GroupTabNumberOfSections)();
typedef void (^DidSelectRowBlcok)(id rowData, NSIndexPath *indexPath);

@interface OKTableDelegateAndDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>


/** 获取UITableViewStyleGrouped表格Section数目 */
@property (nonatomic, copy) GroupTabNumberOfSections groupTabNumberOfSections;

/** 获取UITableViewStyleGrouped表格数据源 */
@property (nonatomic, strong) GroupTabDataOfSections groupTabDataOfSections;

/** 获取Row高度Block */
@property (nonatomic, copy) HeightForRowBlcok heightForRowBlcok;

/** 获取Section高度Block */
@property (nonatomic, copy) HeightForSectionBlcok heightForSectionBlcok;

/** 获取SectionView的Block */
@property (nonatomic, copy) ViewForSectionBlcok viewForSectionBlcok;

/** 点击Cell回调 */
@property (nonatomic, copy) DidSelectRowBlcok didSelectRowBlcok;

/**
 * 初始化Plain类型表格dataSource
 */
+ (instancetype)dataSourceWithClass:(NSString *)className
                         rowDataArr:(NSArray *)rowDataArr
                 configureCellBlock:(TableViewCellConfigureBlock)configureBlock;

/**
 *  获取数组中的元素
 */
- (id)rowDataForIndexPath:(NSIndexPath *)indexPath;

/**
 *  <UITableViewStylePlain>表格赋值数据源
 */
- (void)loadRowData:(NSArray *)rowDataArr;

@end
