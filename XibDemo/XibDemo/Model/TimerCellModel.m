//
//  TimerCellModel.m
//  XibDemo
//
//  Created by mao wangxin on 2017/7/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "TimerCellModel.h"

@implementation TimerCellModel

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)fireTimer
{
    if (self.defaultTime == 0) {
        self.defaultTime = 10 + (arc4random() % 100);
        self.surplusTime = self.defaultTime;
        
    } else {
        self.surplusTime ++;
    }
    NSLog(@"====Model中的定时器====");
}

/**
 * 开始定时器
 */
- (void)startTimer
{
    [self timer];
}

/**
 * 停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    NSLog(@"========Model中的定时器被释放========");
}


@end
