//
//  XibFiveVC.m
//  XibDemo
//
//  Created by mao wangxin on 2017/7/4.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "XibFiveVC.h"
#import "TimerDataCell.h"
#import "TimerCellModel.h"

static NSString *const kCellId = @"TimerDataCell";

@interface XibFiveVC ()
@property (nonatomic, assign) BOOL setStop;
@end

@implementation XibFiveVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除所有Model中的定时器
    [self.tableDataArr makeObjectsPerformSelector:@selector(stopTimer)];
    
//    self.setStop = YES;
//    [self.plainTableView reloadData];
    
    //移除所有cell中的定时器
    NSArray<TimerDataCell *> *cellArr = self.plainTableView.visibleCells;
    [cellArr makeObjectsPerformSelector:@selector(stopTimer)];
    
//    CGRect rect = [self.plainTableView rectForSection:0];
//    NSArray<NSIndexPath *> *indexPathArr = [self.plainTableView indexPathsForRowsInRect:rect];
//    for (NSIndexPath *indexPath in indexPathArr) {
//        TimerDataCell *cell = [self.plainTableView cellForRowAtIndexPath:indexPath];
//        [cell stopTimer];
//    }
        
    for (TimerCellModel *model in self.tableDataArr) {
        model.setStopFlag = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<50; i++) {
        TimerCellModel *model = [[TimerCellModel alloc] init];
        [self.tableDataArr addObject:model];
    }
    
    //开始计时
    [self.tableDataArr makeObjectsPerformSelector:@selector(startTimer)];
    
    self.plainTableView.rowHeight = 60;
    [self.plainTableView registerNib:[UINib nibWithNibName:@"TimerDataCell" bundle:nil] forCellReuseIdentifier:kCellId];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimerDataCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    TimerCellModel *model = self.tableDataArr[indexPath.row];
    cell.model = model;
//    if (self.setStop) {
//        [cell stopTimer];
//    }
    return cell;
}

@end
