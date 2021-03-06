//
//  OKBaseViewController.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


/** 是否使用全屏返回手势 */
@property (nonatomic, assign) BOOL shouldPanBack;

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
/**
 * 返回上一个控制器，子类可重写
 */
- (void)backBtnClick:(UIButton *)sender;

@end
