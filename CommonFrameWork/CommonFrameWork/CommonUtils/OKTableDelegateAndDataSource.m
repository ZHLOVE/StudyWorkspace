//
//  OKTableDelegateAndDataSource.m
//  OkdeerSeller
//
//  Created by mao wangxin on 2017/8/15.
//  Copyright © 2017年 Okdeer. All rights reserved.
//

#import "OKTableDelegateAndDataSource.h"
#import "UIScrollView+OKRequestExtension.h"
#import "OKPubilcKeyDefiner.h"
#import "OKFrameDefiner.h"

@interface OKTableDelegateAndDataSource ()
@property (nonatomic, strong) NSArray *rowDataArr;
@property (nonatomic, strong) Class cellCalss;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureBlock;
@end

@implementation OKTableDelegateAndDataSource

/**
 * 初始化Plain类型表格dataSource
 */
+ (instancetype)dataSourceWithClass:(NSString *)className
                         rowDataArr:(NSArray *)rowDataArr
                 configureCellBlock:(TableViewCellConfigureBlock)configureBlock
{
    if (![className isKindOfClass:[NSString class]] || className.length==0) {
        return nil;
    } else {
        return [[OKTableDelegateAndDataSource alloc] initWithClass:className
                                                      rowDataArr:rowDataArr
                                              configureCellBlock:configureBlock];
    }
}

- (instancetype)initWithClass:(NSString *)className
                   rowDataArr:(NSArray *)rowDataArr
           configureCellBlock:(TableViewCellConfigureBlock)configureBlock
{
    self = [super init];
    if (self) {
        _cellCalss = NSClassFromString(className);
        _rowDataArr = rowDataArr;
        _cellIdentifier = className;
        _configureBlock = configureBlock;
    }
    return self;
}

/**
 *  获取数组中的元素
 */
- (id)rowDataForIndexPath:(NSIndexPath *)indexPath
{
    if (self.groupTabDataOfSections) {
        NSArray *arrary = self.groupTabDataOfSections(indexPath.section);
        if ([arrary isKindOfClass:[NSArray class]]) {
            if (arrary.count>indexPath.row) {
                return arrary[indexPath.row];
            }
        }
    } else {
        if (indexPath.row < self.rowDataArr.count) {
            return self.rowDataArr[indexPath.row];
        }
    }
    return nil;
}

/**
 *  赋值数据源
 */
- (void)loadRowData:(NSArray *)rowDataArr
{
    if (!self.groupTabNumberOfSections) { //表格类型为:UITableViewStylePlain
        self.rowDataArr = rowDataArr;
    }
}

#pragma mark -===========UITableViewDataSource===========

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.groupTabNumberOfSections) {
        return self.groupTabNumberOfSections();
    } else {
        if (_rowDataArr.count != 0) {
            return 1;
        } else {
            return 0;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.groupTabDataOfSections) {
        NSArray *arrary = self.groupTabDataOfSections(section);
        return arrary.count;
    } else {
        return _rowDataArr.count;
    }
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (!cell) {
        if ([_cellCalss isSubclassOfClass:[UITableViewCell class]]) {
            cell = [[_cellCalss alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
        }
    }
    id rowData = [self rowDataForIndexPath:indexPath];
    if (self.configureBlock) {
        self.configureBlock(cell, rowData, indexPath);
    } else {
        SEL sel = @selector(setDataModel:);
        if ([cell respondsToSelector:sel]) {
            OKPerformSelectorLeakWarning(
             [cell performSelector:sel withObject:rowData];
            );
        }
    }
    return cell;
}

#pragma mark -===========UITableViewDelegate===========

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightForRowBlcok) {
        id rowData = [self rowDataForIndexPath:indexPath];
        return self.heightForRowBlcok(rowData, indexPath);
    } else {
        return kDefaultCellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.heightForSectionBlcok) {
        return self.heightForSectionBlcok(HeaderType, section);
    } else {
        return OKMaxPixelSize;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.heightForSectionBlcok) {
        return self.heightForSectionBlcok(FooterType, section);
    } else {
        return OKMaxPixelSize;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.viewForSectionBlcok) {
        return self.viewForSectionBlcok(HeaderType, section);
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.viewForSectionBlcok) {
        return self.viewForSectionBlcok(FooterType, section);
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRowBlcok) {
        id rowData = [self rowDataForIndexPath:indexPath];
        self.didSelectRowBlcok(rowData, indexPath);
    }
}

-(void)dealloc{
    self.configureBlock = nil;
    self.groupTabNumberOfSections = nil;
    self.groupTabDataOfSections = nil;
    self.heightForRowBlcok = nil;
    self.heightForSectionBlcok = nil;
    self.viewForSectionBlcok = nil;
    self.didSelectRowBlcok = nil;
}

@end
