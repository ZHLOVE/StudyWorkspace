//
//  TimerCellModel.h
//  XibDemo
//
//  Created by mao wangxin on 2017/7/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerCellModel : NSObject

@property (nonatomic, assign) NSUInteger defaultTime;

@property (nonatomic, assign) NSInteger surplusTime;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL setStopFlag;

/**
 * 开始定时器
 */
- (void)startTimer;

/**
 * 停止定时器
 */
- (void)stopTimer;

@end
