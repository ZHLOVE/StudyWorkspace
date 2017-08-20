//
//  OKShareView.m
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKShareView.h"
#import "UIView+OKExtension.h"
#import "OKPubilcKeyDefiner.h"
#import "OKFrameDefiner.h"
#import "OKColorDefiner.h"
#import <UIButton+OKExtension.h>

/** actionSheet点击灰色背景消失时的buttonIndex */
#define OKActionSheetDismissIndext (2017)

@interface OKShareView ()

/** 按钮操作事件view */
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;
/** 按钮操作事件回调 */
@property (nonatomic, copy) void(^callBackBlock)(NSInteger buttonIndex);
@end

@implementation OKShareView

#pragma mark - ====================== 只显示分享view ======================

+ (instancetype)showShareViewWithTitle:(id)title
                          itemTitleArr:(NSArray *)titleArr
                          itemImageArr:(NSArray *)imageArr
                             callBlock:(void(^)(NSInteger buttonIndex))callBlock
{
    if (titleArr.count != imageArr.count || imageArr.count==0) {
        return nil;
    }
    
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds
                              tipTitle:title
                          itemTitleArr:(NSArray *)titleArr
                          itemImageArr:(NSArray *)imageArr
                                 block:callBlock];
}

- (instancetype)initWithFrame:(CGRect)frame
                     tipTitle:(id)tipTitle
                 itemTitleArr:(NSArray *)titleArr
                 itemImageArr:(NSArray *)imageArr
                        block:(void(^)(NSInteger buttonIndex))callBackBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.0;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        
        self.titleArr = titleArr;
        self.imageArr = imageArr;
        self.callBackBlock = callBackBlock;
        
        //点击背景消失
        UIControl *control = [[UIControl alloc] initWithFrame:self.frame];
        [control addTarget:self action:@selector(dismissShareView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        //创建分享UI
        [self initUIWithTip:tipTitle];
        
        //显示在窗口
        [self showShareView];
    }
    return self;
}

#pragma mark - 创建分享View

/**
 *  创建分享页面
 */
- (void)initUIWithTip:(id)tipTitle
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, 100)];
    contentView.backgroundColor = WhiteColor;
    [self addSubview:contentView];
    self.contentView = contentView;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, Screen_Width, 20)];
    [titleLab setTextColor:UIColorFromHex(0x323232)];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [titleLab setFont:FONTSYSTEM(18)];
    [contentView addSubview:titleLab];
    
    //根据文字类型设置标题
    if ([tipTitle isKindOfClass:[NSString class]]) {
        titleLab.text = tipTitle;
    } else if([tipTitle isKindOfClass:[NSAttributedString class]]){
        titleLab.attributedText = tipTitle;
    } else {
        titleLab.text = @"分享";
    }
    
    NSInteger itemCount = self.imageArr.count;
    CGFloat maxHeight = CGRectGetMaxY(titleLab.frame)+15;
    
    int maxCols = 4;
    CGFloat buttonW = 60;
    CGFloat buttonH = 70;
    CGFloat startY = maxHeight;
    CGFloat startX = (Screen_Width-buttonW * maxCols) / (maxCols+1);//间隔距离
    
    //所有分享按钮
    for (int j = 0; j<itemCount; j++) {
        UIButton *itemBtn = [[UIButton alloc] init];
        itemBtn.width = buttonW;
        itemBtn.height = buttonH;
        int row = j / maxCols;
        int col = j % maxCols;
        itemBtn.x = startX + col * (startX + buttonW);
        itemBtn.y = startY + row * (buttonH + 10);
        
        [itemBtn setImage:self.imageArr[j] forState:0];
        [itemBtn setTitle:self.titleArr[j] forState:0];
        [itemBtn setTitleColor:UIColorFromHex(0x323232) forState:0];
        itemBtn.titleLabel.font = FONTSYSTEM(12);
        itemBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [itemBtn layoutImageOrTitleEdgeInsets:OKButtonEdgeInsetsStyleTop imageTitleSpace:5];
        [itemBtn addTarget:self action:@selector(chooseItemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:itemBtn];
        itemBtn.tag = j;
        
        maxHeight = CGRectGetMaxY(itemBtn.frame)+20;
    }
    contentView.height = maxHeight;
    
    //添加到根视图最上层,不另外创建window,状态栏会变黑
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window endEditing:YES];
    [window addSubview:self];
}

/**
 *  选择分享按钮
 */
- (void)chooseItemBtnAction:(UIButton *)btn
{
    if (self.callBackBlock) {
        self.callBackBlock(btn.tag);
    }
    [self dismissShareView:nil];
}

/**
 *  显示弹框
 */
- (void)showShareView
{
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self setAlpha:1];
        self.contentView.y = Screen_Height - self.contentView.height;
    } completion:nil];
}

/**
 *  退出弹框
 */
- (void)dismissShareView:(id)sender
{
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.y = Screen_Height;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0];
        
    } completion:^(BOOL finished) {
        if (sender) {
            NSLog(@"点击了ActionSheet灰色背景消失的index为2017");
            if (self.callBackBlock) {
                self.callBackBlock(OKActionSheetDismissIndext);
            }
        }
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
