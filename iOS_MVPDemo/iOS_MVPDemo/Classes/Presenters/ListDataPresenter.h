//
//  ListDataPresenter.h
//  iOS_MVPDemo
//
//  Created by mao wangxin on 2017/8/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKHttpRequestTools+OKExtension.h"

@interface ListDataPresenter : NSObject

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIViewController *viewController;

/**
 * 分页请求列表数据
 */
- (void)reqPageListData:(BOOL)firstPage callBack:(void(^)(NSArray *array))block;

@end
