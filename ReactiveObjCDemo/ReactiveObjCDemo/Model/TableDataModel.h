//
//  TableDataModel.h
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface TableDataModel : NSObject

@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSString *title;

@end


@interface RequestViewModel : NSObject<UITableViewDataSource>

// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;
//模型数组
@property (nonatomic, strong, readonly) NSArray *models;
// 控制器中的表格
@property (nonatomic, strong) UITableView *tableView;
// 控制器中的view
@property (nonatomic, strong) UIView *vcView;

@end
