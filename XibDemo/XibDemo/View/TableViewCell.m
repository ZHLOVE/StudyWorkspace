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

- (CGFloat)getHeightByModel:(DataModel *)dataModel
{
    self.weiboTextLab.text = dataModel.weiboContent;
    
    [self layoutIfNeeded];
    
    CGFloat btnMaxH = CGRectGetMaxY(self.praiseBtn.frame);
    
    NSLog(@"WeiboCell===%.2f",btnMaxH);
    
    return btnMaxH + 10;
}

- (IBAction)praiseAction:(UIButton *)sender
{
    NSLog(@"赞一个");
    if (self.praiseBlock) {
        self.praiseBlock(@"哈哈");
    }
}

@end
