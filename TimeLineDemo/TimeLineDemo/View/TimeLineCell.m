//
//  TimeLineCell.m
//  TimeLineDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "TimeLineCell.h"
#import "UIImageView+WebCache.h"
#import <OKFrameDefiner.h>
#import <UIView+OKExtension.h>

#define kImgSize ((Screen_Width-75-10-15)/3)

@interface TimeLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *useNameLab;
@property (weak, nonatomic) IBOutlet UILabel *themeLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UIView *picView;
/* 图片View高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picViewHeightConst;
@property (weak, nonatomic) IBOutlet UIButton *dcBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet UIButton *msgLab;
@end

@implementation TimeLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userImageView.layer.cornerRadius = 25;
    self.userImageView.layer.masksToBounds = YES;
    
    self.dcBtn.layer.cornerRadius = 3;
    self.dcBtn.layer.borderColor = [UIColor blueColor].CGColor;
    self.dcBtn.layer.borderWidth = 1;
    self.dcBtn.layer.masksToBounds = YES;
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins = UIEdgeInsetsZero;
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset = UIEdgeInsetsZero;
    }
    
    CGFloat buttonStartX = 0;
    CGFloat margin = 5;
    int maxCols = 3;
    CGFloat imgSize = kImgSize;
    for (int i=0; i<9; i++) {
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor grayColor];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 2017+i;
        imgView.hidden = YES;
        
        int row = i / maxCols;
        int col = i % maxCols;
        imgView.x = buttonStartX + col * (margin + imgSize);
        imgView.y = buttonStartX + row * (margin + imgSize);
        imgView.width = imgSize;
        imgView.height = imgSize;
        [self.picView addSubview:imgView];
    }
}

/**
 *  设置数据源
 */
- (void)setDataModel:(TimeLineDataModel *)dataModel
{
    _dataModel = dataModel;
    
    //头像
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.post.userIcon]];
    //名字
    self.useNameLab.text = dataModel.post.username;
    //主题
    self.themeLab.text = dataModel.post.title;
    //描述
    self.descLab.text = dataModel.post.content;
    //相机
    [self.dcBtn setTitle:dataModel.post.boardname forState:0];
    //时间
    self.timeLab.text = dataModel.post.lastdate;
    //查看数
    [self.readBtn setTitle:dataModel.post.watch forState:0];
    //消息数
    [self.msgLab setTitle:dataModel.post.reply forState:0];
    
    //设置所有图片高度
    [self setupPicViewHeight];
}


/**
 *  设置所有图片高度
 */
- (void)setupPicViewHeight
{
    [self layoutIfNeeded];
    
    CGFloat margin = 5;
    CGFloat maxHeight = 0;
    CGFloat imgH = kImgSize;
    
    NSArray *picArr = self.dataModel.post.imageList;
    if (picArr.count>0) {
        if (picArr.count<=3) {
            margin = margin*0;
            maxHeight = imgH;
            
        } else if(picArr.count<=6){
            margin = margin*1;
            maxHeight = imgH*2;
            
        } else {
            margin = margin*2;
            maxHeight = imgH*3;
        }
    } else {
        margin = margin*0;
        maxHeight = imgH*0;
    }
    self.picViewHeightConst.constant = maxHeight + margin;
    
    //设置所有图片
    for (int i=0; i<9; i++) {
        UIImageView *imgView = (UIImageView *)[self.picView viewWithTag:(2017+i)];
        imgView.hidden = YES;
        if (i<picArr.count) {
            imgView.hidden = NO;
            if ([imgView isKindOfClass:[UIImageView class]]) {
                [imgView sd_setImageWithURL:[NSURL URLWithString:picArr[i]]];
            }
        }
    }
    
    NSLog(@"设置所有图片高度===%.2f====%.2f====%.2f-------%zd",imgH, maxHeight, margin, picArr.count);
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}


- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    CGFloat btnMaxH = CGRectGetMaxY(self.msgLab.frame) + 15;
    NSLog(@"cellHeight===%.2f",btnMaxH);
    return btnMaxH;
}

@end
