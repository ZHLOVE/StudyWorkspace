//
//  OKBaseViewController.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


/** 基类设置公用plain样式表格，由子类创建显示 */
@property (nonatomic, strong) UITableView *plainTableView;

/** 基类设置公用grouped样式表格，由子类创建显示 */
@property (nonatomic, strong) UITableView *groupedTableView;

/** 由子公用表格数据源数组 */
@property (nonatomic, strong) NSMutableArray *tableDataArr;


/** 子类请求对象数组 */
@property (nonatomic, strong) NSMutableArray <NSURLSessionDataTask *> *sessionDataTaskArr;

/**
 * 取消子类所有请求操作
 */
- (void)cancelRequestSessionTask;

@end
