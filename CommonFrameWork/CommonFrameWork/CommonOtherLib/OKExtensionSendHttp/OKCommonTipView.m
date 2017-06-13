//
//  CCParkingRequestTipView.m
//  OkdeerUser
//
//  Created by mao wangxin on 2016/11/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "OKCommonTipView.h"
#import "UIView+OKExtension.h"

#ifndef UIColorFromHex
#define UIColorFromHex(hexValue)            ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:1.0])
#endif


@implementation MBProgressHUD (Extension)

#pragma mark - 弹框在指定view上

/**
 *  获取子view
 */
+ (UIView *)getHUDFromSubview:(UIView *)addView
{
    if (addView) {
        for (UIView *tipVieww in addView.subviews) {
            if ([tipVieww isKindOfClass:[MBProgressHUD class]]) {
                if (tipVieww.superview) {
                    [tipVieww removeFromSuperview];
                }
            }
        }
    } else {
        addView = [UIApplication sharedApplication].keyWindow;
    }
    return addView;
}

/**
 *  隐藏指定view上创建的MBProgressHUD
 */
+ (void)hideLoadingFromView:(UIView *)view
{
    for (UIView *tipView in view.subviews) {
        if ([tipView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *HUD = (MBProgressHUD *)tipView;
            if (tipView.superview) {
                [tipView removeFromSuperview];
            }
            [HUD showAnimated:YES];
        }
    }
}


/**
 *  在指定view上显示转圈的MBProgressHUD (不会自动消失,需要手动调用隐藏方法)
 *
 *  @param tipStr 提示语
 */
+ (void)showLoadingWithView:(UIView *)addView text:(NSString *)tipStr
{
    addView = [self getHUDFromSubview:addView];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:addView];
    [addView addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.userInteractionEnabled = NO;
    HUD.label.text = tipStr;
    [HUD showAnimated:YES];
}

@end


@interface OKCommonTipView ()
@property (nonatomic, copy) void(^block)();
@end

@implementation OKCommonTipView

/**
 返回一个提示空白view
 
 @param frame 提示View大小
 @param image 图片名字
 @param text 提示文字
 @param title 按钮标题, 不要按钮可不传
 @param block 点击按钮回调Block
 @return 提示空白view
 */
+ (OKCommonTipView *)tipViewByFrame:(CGRect)frame
                           tipImage:(UIImage *)image
                            tipText:(id)text
                        actionTitle:(id)title
                        actionBlock:(void(^)())block
{
    OKCommonTipView *tipView = [[OKCommonTipView alloc] initWithFrame:frame
                                                             tipImage:image
                                                              tipText:text
                                                          actionTitle:title
                                                          actionBlock:block];
    tipView.tag = kRequestTipViewTag;
    tipView.backgroundColor = UIColorFromHex(0xf5f6f8);
    return tipView;
}

- (instancetype)initWithFrame:(CGRect)frame
                     tipImage:(UIImage *)image
                      tipText:(id)text
                  actionTitle:(id)title
                  actionBlock:(void(^)())block
{
    self = [super initWithFrame:frame];
    if(self){
        self.block = block;
        
        CGFloat spaceMargin = 5;
        UIView *contenView = [[UIView alloc] init];
        contenView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        contenView.backgroundColor = [UIColor clearColor];
        [self addSubview:contenView];
        
        CGFloat contenViewMaxHeight = 0;
        
        //顶部图片
        UIImageView *_tipImageView = nil;
        if (image) {
            _tipImageView = [[UIImageView alloc] initWithImage:image];
            _tipImageView.contentMode = UIViewContentModeScaleAspectFill;
            [contenView addSubview:_tipImageView];
            _tipImageView.centerX = contenView.width/2;
            
            contenViewMaxHeight = CGRectGetMaxY(_tipImageView.frame)+spaceMargin;
        }
        
        //中间文字
        UILabel *_tipLabel = nil;
        if (text) {
            _tipLabel = [[UILabel alloc] init];
            _tipLabel.font = [UIFont boldSystemFontOfSize:14];
            _tipLabel.textColor = UIColorFromHex(0x666666);
            _tipLabel.textAlignment = NSTextAlignmentCenter;
            _tipLabel.numberOfLines = 0;
            [contenView addSubview:_tipLabel];
            
            if ([text isKindOfClass:[NSString class]]) {
                _tipLabel.text = text;
            } else if ([text isKindOfClass:[NSAttributedString class]]) {
                _tipLabel.attributedText = text;
            }
            [_tipLabel sizeToFit];
            _tipLabel.centerX = contenView.width/2;
            _tipLabel.y = contenViewMaxHeight;
            
            contenViewMaxHeight = CGRectGetMaxY(_tipLabel.frame)+spaceMargin;
        }
        
        //底部按钮
        if (title) {
            UIButton *actionBtn = [[UIButton alloc] init];
            actionBtn.backgroundColor = [UIColor whiteColor];
            actionBtn.layer.cornerRadius = 6;
            actionBtn.layer.borderColor = UIColorFromHex(0x666666).CGColor;
            actionBtn.layer.borderWidth = 1;
            [actionBtn setTitleColor:UIColorFromHex(0x666666) forState:0];
            actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            actionBtn.titleLabel.numberOfLines = 0;
            [actionBtn addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
            [contenView addSubview:actionBtn];
            
            if ([title isKindOfClass:[NSString class]]) {
                [actionBtn setTitle:title forState:0];
            } else if ([title isKindOfClass:[NSAttributedString class]]) {
                [actionBtn setAttributedTitle:title forState:00];
            }
            [actionBtn sizeToFit];
            actionBtn.width += 30;
            actionBtn.centerX = contenView.width/2;
            actionBtn.y = contenViewMaxHeight;
            
            contenViewMaxHeight = CGRectGetMaxY(actionBtn.frame)+spaceMargin;
            self.actionBtn = actionBtn;
        }
        contenView.height = contenViewMaxHeight;
        contenView.y = (frame.size.height-contenView.height)/2;
    }    
    return self;
}

/**
 * 提示按钮点击事件
 */
- (void)buttonAction
{
    if (self.block) {
        self.block();
    }
}

@end
