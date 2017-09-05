//
//  OKTableDelegateOrDataSource.h
//  OkdeerSeller
//
//  Created by mao wangxin on 2017/8/15.
//  Copyright © 2017年 Okdeer. All rights reserved.
//
//  表格的Delegate和DataSource

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HeaderType,
    FooterType,
} SectionType;

typedef void (^TableViewCellConfigureBlock) (id cell, id rowData, NSIndexPath *indexPath);


@interface OKTableDelegateOrDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>


/** 获取UITableViewStyleGrouped表格Section数目 */
@property (nonatomic, copy) NSInteger (^groupTabNumberOfSections)();

/** 获取UITableViewStyleGrouped表格每个section的数据源 */
@property (nonatomic, copy) NSArray* (^groupTabDataOfSections)(NSInteger section);

/** 获取UITableViewStylePlain表格所有row数据源 */
@property (nonatomic, copy) NSArray* (^plainTabDataArrBlcok)();

/** 获取Row高度Block */
@property (nonatomic, copy) CGFloat (^heightForRowBlcok)(id rowData, NSIndexPath *indexPath);

/** 获取SectionView高度Block */
@property (nonatomic, copy) CGFloat (^heightForSectionBlcok)(SectionType sectionType,NSInteger section);

/** 获取SectionView的Block */
@property (nonatomic, copy) UIView * (^viewForSectionBlcok)(SectionType sectionType,NSInteger section);

/** 点击Cell回调 */
@property (nonatomic, copy) void (^didSelectRowBlcok)(id rowData, NSIndexPath *indexPath);

/**
 * 创建表格dataSource
 */
+ (instancetype)createWithCellClass:(Class)cellClass
                          isXibCell:(BOOL)isXibCell
                 configureCellBlock:(TableViewCellConfigureBlock)configureBlock;

/**
 *  获取数组中的元素
 */
- (id)rowDataForIndexPath:(NSIndexPath *)indexPath;

@end
