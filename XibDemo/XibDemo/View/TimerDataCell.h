//
//  TimerDataCell.h
//  XibDemo
//
//  Created by mao wangxin on 2017/7/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimerCellModel;

@interface TimerDataCell : UITableViewCell

@property (nonatomic, strong) TimerCellModel *model;

/**
 * 停止定时器
 */
- (void)stopTimer;

@end
