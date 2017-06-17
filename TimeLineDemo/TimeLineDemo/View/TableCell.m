//
//  TableCell.m
//  MVVMDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDataModel:(TableDataModel *)dataModel
{
    _dataModel = dataModel;
    
    //    self.weiboTextLab.text = dataModel.weiboContent;
}


- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    //    CGFloat btnMaxH = CGRectGetMaxY(self.praiseBtn.frame) + 10;
    //    NSLog(@"cellHeight===%.2f",btnMaxH);
    return 100;//btnMaxH;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //    CGFloat btnMaxH = CGRectGetMaxY(self.praiseBtn.frame)+ 10;
    //    NSLog(@"drawRect===%.2f",btnMaxH);
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    //    self.weiboTextLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
