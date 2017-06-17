//
//  TableViewCell.m
//  XibDemo
//
//  Created by Luke on 2017/6/15.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "TableViewCell.h"
#import <OKFrameDefiner.h>
#import <UIView+OKExtension.h>

@interface TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *weiboTextLab;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(DataModel *)dataModel
{
    _dataModel = dataModel;
    
    self.weiboTextLab.text = dataModel.weiboContent;
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    CGFloat btnMaxH = CGRectGetMaxY(self.praiseBtn.frame) + 10;
    NSLog(@"cellHeight===%.2f",btnMaxH);
    return btnMaxH;
}

- (IBAction)praiseAction:(UIButton *)sender
{
    NSLog(@"赞一个");
    if (self.praiseBlock) {
        self.praiseBlock(@"哈哈");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.weiboTextLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    self.weiboTextLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
