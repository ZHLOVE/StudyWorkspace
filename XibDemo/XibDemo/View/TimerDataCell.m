//
//  TimerDataCell.m
//  XibDemo
//
//  Created by mao wangxin on 2017/7/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "TimerDataCell.h"
#import "TimerCellModel.h"

@interface TimerDataCell ()
@property (weak, nonatomic) IBOutlet UILabel *defaultTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TimerDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self timer];
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)fireTimer
{
    if (_model.setStopFlag) {
        NSLog(@"数据源已经销毁时移除定时器===%@",_timer);
        [self stopTimer];
        return;
    }
    self.defaultTimeLabel.text = [NSString stringWithFormat:@"默认时间：%zd",self.model.defaultTime];
    self.timeLabel.text = [NSString stringWithFormat:@"累计时间：%zd",self.model.surplusTime];
    NSLog(@"-------------cell中的定时器-------------");
}

/**
 * 停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)setModel:(TimerCellModel *)model
{
    _model = model;
    self.defaultTimeLabel.text = [NSString stringWithFormat:@"默认时间：%zd",model.defaultTime];
    self.timeLabel.text = [NSString stringWithFormat:@"累计时间：%zd",model.surplusTime];
}

- (void)dealloc
{
    NSLog(@"------cell中的定时器被释放------");
}

@end
