//
//  OKTableDelegateOrDataSource.m
//  OkdeerSeller
//
//  Created by mao wangxin on 2017/8/15.
//  Copyright © 2017年 Okdeer. All rights reserved.
//

#import "OKTableDelegateOrDataSource.h"
#import "UIScrollView+OKRequestExtension.h"
#import "OKPubilcKeyDefiner.h"
#import "OKFrameDefiner.h"
#import <UIView+OKTool.h>

#define kMinSectionHeight          (0.001)

@interface OKTableDelegateOrDataSource ()
@property (nonatomic, strong) Class CellCalss;
@property (nonatomic, assign) BOOL isXibCell;
@property (nonatomic, copy)   NSString *cellIdentifier;
@property (nonatomic, copy)   TableViewCellConfigureBlock configureBlock;
@end

@implementation OKTableDelegateOrDataSource

/**
 * 创建表格dataSource
 */
+ (instancetype)createWithCellClass:(Class)cellClass
                          isXibCell:(BOOL)isXibCell
                 configureCellBlock:(TableViewCellConfigureBlock)configureBlock
{
    NSString *className = NSStringFromClass(cellClass);
    if (!cellClass || className.length==0) {
        return nil;
    } else {
        return [[OKTableDelegateOrDataSource alloc] initWithClass:className
                                                        isXibCell:isXibCell
                                               configureCellBlock:configureBlock];
    }
}


- (instancetype)initWithClass:(NSString *)className
                    isXibCell:(BOOL)isXibCell
           configureCellBlock:(TableViewCellConfigureBlock)configureBlock
{
    self = [super init];
    if (self) {
        self.isXibCell = isXibCell;
        self.CellCalss = NSClassFromString(className);
        self.cellIdentifier = className;
        self.configureBlock = configureBlock;
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
    } else if (self.plainTabDataArrBlcok) {
        NSArray *rowDataArr = self.plainTabDataArrBlcok();
        if ([rowDataArr isKindOfClass:[NSArray class]]) {
            if (indexPath.row < rowDataArr.count) {
                return rowDataArr[indexPath.row];
            }
        }
    }
    return nil;
}

#pragma mark -===========UITableViewDataSource===========

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.groupTabNumberOfSections) {
        return self.groupTabNumberOfSections();
    } else {
        if (self.plainTabDataArrBlcok) {
            if (self.plainTabDataArrBlcok().count != 0) {
                return 1;
            }
        }
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.groupTabDataOfSections) {
        NSArray *arrary = self.groupTabDataOfSections(section);
        return arrary.count;
    } else {
        if (self.plainTabDataArrBlcok) {
            return self.plainTabDataArrBlcok().count;
        }
        return 0;
    }
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (!cell) {
        NSAssert([_CellCalss isSubclassOfClass:[UITableViewCell class]], @"❌❌❌初始化参数:cellClass 必须为UITableViewCell的类型");
        
        if (self.isXibCell && [_cellIdentifier isEqualToString:@"UITableViewCell"]) {
            NSAssert(NO, @"❌❌❌请检查初始化参数:cellClass类是否为Xib");
        }
        
        if (self.isXibCell) {//注册xib Cell
            cell = [_CellCalss viewFromXib];
            
        } else { //初始化非Xib Cell
            cell = [[_CellCalss alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
        }
    }
    id rowData = [self rowDataForIndexPath:indexPath];
    if (self.configureBlock) {
        self.configureBlock(cell, rowData, indexPath);
    } else {
        SEL sel = NSSelectorFromString(@"setDataModel:");
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
        return kMinSectionHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.heightForSectionBlcok) {
        return self.heightForSectionBlcok(FooterType, section);
    } else {
        return kMinSectionHeight;
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
    self.plainTabDataArrBlcok = nil;
    self.heightForRowBlcok = nil;
    self.heightForSectionBlcok = nil;
    self.viewForSectionBlcok = nil;
    self.didSelectRowBlcok = nil;
}

@end
