//
//  CellView.h
//  XibDemo
//
//  Created by mao wangxin on 2017/6/16.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface CellView : UIView

@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;

/** 点赞回调 */
@property (nonatomic, copy) void (^praiseBlock)(NSString *);

/** 数据源 */
@property (nonatomic, strong) DataModel *dataModel;

@end
