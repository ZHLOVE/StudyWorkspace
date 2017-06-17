//
//  TableCell.h
//  MVVMDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewModel.h"

@interface TableCell : UITableViewCell

/** 数据源 */
@property (nonatomic, strong) TableDataModel *dataModel;

/** 获取cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
