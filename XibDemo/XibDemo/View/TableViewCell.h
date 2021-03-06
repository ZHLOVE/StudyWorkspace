//
//  TableViewCell.h
//  XibDemo
//
//  Created by Luke on 2017/6/15.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface TableViewCell : UITableViewCell

/** 点赞回调 */
@property (nonatomic, copy) void (^praiseBlock)(NSString *);

/** 数据源 */
@property (nonatomic, strong) DataModel *dataModel;

/** 获取cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
