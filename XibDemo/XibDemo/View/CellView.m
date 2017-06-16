//
//  CellView.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/16.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CellView.h"

#import <OKFrameDefiner.h>

@interface  CellView ()
@property (weak, nonatomic) IBOutlet UILabel *weiboTextLab;
@end

@implementation CellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(DataModel *)dataModel
{
    _dataModel = dataModel;
    
    self.weiboTextLab.text = dataModel.weiboContent;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat btnMaxH = CGRectGetMaxY(self.praiseBtn.frame);
    
    NSLog(@"drawRect===%.2f",btnMaxH);
}

- (IBAction)praiseAction:(UIButton *)sender
{
    NSLog(@"赞一个");
    if (self.praiseBlock) {
        self.praiseBlock(@"哈哈");
    }
}


@end
