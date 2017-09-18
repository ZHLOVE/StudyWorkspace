//
//  OKPickerView.m
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKPickerView.h"
#import "UIView+OKExtension.h"
#import "OKPubilcKeyDefiner.h"
#import "OKFrameDefiner.h"
#import "OKColorDefiner.h"

#define contentViewHeight  (Screen_Height*0.4)
#define topHeight  44
#define topButtonW  60

@interface OKPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, copy) void(^sureBlock)(NSInteger rowIndex);
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, strong) NSArray *pickDataArr;
@property (nonatomic, assign) NSInteger selectedRowIndex;
@end

@implementation OKPickerView


/**
 选择器
 
 @param title 标题
 @param pickDataArr 选择器每一行内容
 @param sureBlock 确定block
 @param cancelBlock 取消block
 @return  选择器实例
 */
+ (instancetype)showPickerViewWithTitle:(id)title
                            pickDataArr:(NSArray *)pickDataArr
                              sureBlock:(void(^)(NSInteger rowIndex))sureBlock
                            cancelBlock:(void (^)(void))cancelBlock
{
    //按钮至少要有一个
    if(pickDataArr.count == 0) return nil;
    
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds
                                 title:title pickDataArr:pickDataArr
                             sureBlock:sureBlock
                           cancelBlock:cancelBlock];
}


#pragma mark - 自定义PickerView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(id)title
                  pickDataArr:(NSArray *)pickDataArr
                    sureBlock:(void(^)(NSInteger rowIndex))sureBlock
                  cancelBlock:(void (^)())cancelBlock
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.sureBlock = sureBlock;
        self.cancelBlock = cancelBlock;
        self.pickDataArr = pickDataArr;
        
        self.alpha = 0.0;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        
        //点击背景消失
        UIControl *control = [[UIControl alloc] initWithFrame:self.frame];
        [control addTarget:self action:@selector(dismissGJPickerView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        //显示UI
        [self initSquareActionSheetUI:title];
        
        //动画显示在窗口
        [self showGJPickView];
    }
    return self;
}

#pragma mark - 初始化UI


/**
 *  创建直角的ActionSheet
 */
- (void)initSquareActionSheetUI:(id)title
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, contentViewHeight)];
    contentView.backgroundColor = WhiteColor;
    [self addSubview:contentView];
    self.contentView = contentView;
    
    //取消
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, topButtonW, topHeight)];
    cancelBtn.backgroundColor = WhiteColor;
    [cancelBtn setTitle:@"取消" forState:0];
    [cancelBtn.titleLabel setFont:FONTSYSTEM(16)];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:Color_BlackFont forState:0];
    [cancelBtn setTitleColor:[Color_BlackFont colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [contentView addSubview:cancelBtn];
    
    //标题
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), 0, Screen_Width-topButtonW*2, topHeight)];
    [titleLab setTextColor:UIColorFromHex(0x666666)];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [titleLab setFont:FONTSYSTEM(16)];
    [titleLab setBackgroundColor:WhiteColor];
    titleLab.numberOfLines = 0;
    [contentView addSubview:titleLab];
    //根据文字类型设置标题
    if ([title isKindOfClass:[NSString class]]) {
        titleLab.text = title;
    } else if([title isKindOfClass:[NSAttributedString class]]){
        titleLab.attributedText = title;
    } else {
        titleLab.text = @"选择器";
    }
    
    //确定
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), 0, topButtonW, topHeight)];
    sureBtn.backgroundColor = WhiteColor;
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn.titleLabel setFont:FONTSYSTEM(16)];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:Color_BlackFont forState:0];
    [sureBtn setTitleColor:[Color_BlackFont colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [contentView addSubview:sureBtn];
    
    //线条
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sureBtn.frame), Screen_Width, 1)];
    line.backgroundColor = Color_Line;
    [contentView addSubview:line];
    
    //选择器
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), Screen_Width, contentViewHeight-topHeight)];
    pickView.delegate = self;
    pickView.dataSource = self;
    [contentView addSubview:pickView];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window endEditing:YES];
    [window addSubview:self];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickDataArr.count;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id objStr = self.pickDataArr[row];
    if ([objStr isKindOfClass:[NSAttributedString class]]) {
        return objStr;
    } else if ([objStr isKindOfClass:[NSString class]]) {
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:objStr];
        return attr;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"didSelectRow===%@",self.pickDataArr[row]);
    if (self.pickDataArr.count > row) {
        self.selectedRowIndex = row;
    }
}

#pragma mark - 确定和取消事件处理

- (void)cancelBtnAction:(UIButton *)button
{
    [self dismissGJPickerView:button];
}

- (void)sureBtnAction:(UIButton *)button
{
    if ( self.sureBlock) {
        self.sureBlock(self.selectedRowIndex);
    }
    [self dismissGJPickerView:button];
}

#pragma mark - 显示和影藏弹框

/**
 *  显示弹框
 */
- (void)showGJPickView
{
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self setAlpha:1];
        self.contentView.y = Screen_Height - self.contentView.height;
    } completion:nil];
}

/**
 *  退出弹框
 */
- (void)dismissGJPickerView:(id)sender
{
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.y = Screen_Height;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0];
    } completion:^(BOOL finished) {
        if (sender) {
            NSLog(@"点击了ActionSheet灰色背景消失");
            if (self.cancelBlock) {
                self.cancelBlock();
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
