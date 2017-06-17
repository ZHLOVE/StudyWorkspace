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
