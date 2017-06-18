//
//  TimeLineViewModel.m
//  TimeLineDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "TimeLineViewModel.h"
#import "TimeLineCell.h"

@implementation Post;
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imageList" : @"Imagelist"
             };
}

- (void)setLastdate:(NSString *)lastdate
{
    _lastdate = [self compareCurrentTime:lastdate];
}


/**
 * 时间格式实现几天前，几小时前，几分钟前
 */
- (NSString *)compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

@end


@implementation TimeLineDataModel;

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"postList" : @"Postlist"
             };
}

- (void)calculateCellHeight
{
    //利用Xib计算Cell高度
    TimeLineCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TimeLineCell" owner:nil options:nil] lastObject];
    cell.dataModel = self;
    self.cellHeight = cell.cellHeight;
}

@end


@implementation TimeLineViewModel
@end
