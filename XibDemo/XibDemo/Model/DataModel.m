//
//  DataModel.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/6.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "DataModel.h"
#import "TableViewCell.h"

@implementation DataModel

- (void)setWeiboContent:(NSString *)weiboContent
{
    _weiboContent = weiboContent;
    
    TableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];

    self.cellHeight = [cell getHeightByModel:self];
}

@end
