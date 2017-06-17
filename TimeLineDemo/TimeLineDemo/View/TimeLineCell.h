//
//  TimeLineCell.h
//  TimeLineDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineViewModel.h"

@interface TimeLineCell : UITableViewCell

/** 数据源 */
@property (nonatomic, strong) TimeLineDataModel *dataModel;

/** 获取cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
