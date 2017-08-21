//
//  OKTagetSliderView.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/8/21.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKTagetSliderView.h"
#import "OKPubilcKeyDefiner.h"
#import "UIButton+OKExtension.h"
#import "OKColorDefiner.h"
#import "UIView+OKExtension.h"
#import "UIView+OKBadge.h"
#import <UIView+OKTool.h>

#define kBtnStartTag    2017

@interface OKTagetSliderView()
@property (nonatomic, strong) UIView *line;
@end

@implementation OKTagetSliderView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr
{
    if (self == [super initWithFrame:frame]) {
        [self setupUI:titleArr];
    }
    return self;
}

- (void)setupUI:(NSArray *)titleArr
{
    CGFloat btnWidth = self.frame.size.width/titleArr.count;
    for (int index = 0; index < [titleArr count]; index++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(index * btnWidth, 0, btnWidth, self.frame.size.height)];
        btn.titleLabel.font = FONTSYSTEM(14);
        btn.tag = kBtnStartTag+index;
        [btn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:titleArr[index] forState:UIControlStateNormal];
        [btn layoutImageOrTitleEdgeInsets:OKButtonEdgeInsetsStyleTop imageTitleSpace:3];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *line = [self addLineToPosition:OkDrawLine_bottom lineWidth:2];
    line.backgroundColor = self.lineColor ? : [UIColor whiteColor];
    line.width = btnWidth;
    self.line = line;
}

- (void)setTextClolr:(UIColor *)textClolr
{
    _textClolr = textClolr;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *subBtn = [self viewWithTag:(kBtnStartTag+i)];
        if ([subBtn isKindOfClass:[UIButton class]]) {
            [subBtn setTitleColor:textClolr forState:UIControlStateNormal];
        }
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.line.backgroundColor = lineColor;
}

/**
 * 设置标题
 */
- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = titleArr;
    for (int i = 0; i<self.subviews.count; i++) {
        NSString *title = titleArr[i];
        UIButton *subBtn = [self viewWithTag:(kBtnStartTag+i)];
        
        if ([title isKindOfClass:[NSString class]] &&
            [subBtn isKindOfClass:[UIButton class]]) {
            [subBtn setTitle:title forState:0];
            [subBtn layoutImageOrTitleEdgeInsets:OKButtonEdgeInsetsStyleTop imageTitleSpace:3];
        }
    }
}

/**
 * 设置图标
 */
- (void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    for (int i = 0; i<self.subviews.count; i++) {
        UIImage *image = imageArr[i];
        UIButton *subBtn = [self viewWithTag:(kBtnStartTag+i)];
        
        if ([image isKindOfClass:[UIImage class]] &&
            [subBtn isKindOfClass:[UIButton class]]) {
            [subBtn setImage:image forState:0];
            [subBtn setImage:image forState:UIControlStateHighlighted];
            [subBtn layoutImageOrTitleEdgeInsets:OKButtonEdgeInsetsStyleTop imageTitleSpace:3];
        }
    }
}

/**
 * 设置数目
 */
- (void)setBadgeAtindex:(NSInteger)index badgeNum:(NSInteger)badgeNum
{
    NSLog(@"设置数目===%zd",badgeNum);
    UIButton *subBtn = [self viewWithTag:(kBtnStartTag+index)];
    if (badgeNum>0 && [subBtn isKindOfClass:[UIButton class]]) {
        [subBtn showBadgeWithStyle:WBadgeStyleNumber value:badgeNum];
        [subBtn setBadgeCenterOffset:CGPointMake(-25, 15)];
        [subBtn layoutImageOrTitleEdgeInsets:OKButtonEdgeInsetsStyleTop imageTitleSpace:3];
    }
}

/**
 * 按钮事件
 */
- (void)subBtnAction:(UIButton *)sender
{
    NSInteger index = sender.tag-kBtnStartTag;
    if (self.touchBtnBlock) {
        self.touchBtnBlock(index);
    }
    self.line.x = index * sender.width;
}

@end
