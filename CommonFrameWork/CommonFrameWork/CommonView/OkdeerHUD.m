//
//  OkdeerHUD.m
//  Example
//
//  Created by mao wangxin on 2017/9/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "OkdeerHUD.h"
#import "OKColorDefiner.h"

#define kLayerW                 30     // layer 的宽度
#define kLayerH                 30     // layer 的高度
#define kUIkitSpace             10     // 控件的间距
#define kTitleFont              14     // 提示语的字体大小.
#define kContentViewWidth       120    /** 半透明view宽度 */
#define kContentViewHeight      86     /** 半透明view高度 */

@interface OkdeerHUD ()
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) NSString *tipText;
@property (nonatomic, strong) UIImage *tipimage;
@property (nonatomic, strong) UIView *contentView;         /** 半透明view */
@property (nonatomic, strong) UIView *firstRoundLayer;    /**< 第一圆 */
@property (nonatomic, strong) UIView *secondRoundLayer;   /**< 第二个圆 */
@property (nonatomic, strong) UILabel *textLabel;         /**< 提示语 */
@property (nonatomic, assign) BOOL hideFlag;
@end

@implementation OkdeerHUD

/**
 在window上显示HUD (不会自动消失)
 */
void showLoadingToWindow() {
    UIView *window = [OkdeerHUD fetchHudWindow];
    [OkdeerHUD createHUDView:[UIScreen mainScreen].bounds superView:window tipText:nil tipimage:nil];
}

/**
 在window上显示HUD (不会自动消失)
 
 @param text 提示语
 */
void showLoadingToWindowWithText(NSString *text){
    UIView *window = [OkdeerHUD fetchHudWindow];
    [OkdeerHUD createHUDView:[UIScreen mainScreen].bounds superView:window tipText:text tipimage:nil];
}

/**
 在指定view上显示HUD (不会自动消失)
 
 @param addView HUD的父视图
 */
void showLoadingToView(UIView *addView){
    [OkdeerHUD createHUDView:addView.bounds superView:addView tipText:nil tipimage:nil];
}

/**
 在指定view上显示HUD (不会自动消失)
 
 @param addView HUD的父视图
 @param text 提示语
 */
void showLoadingToViewWithText(UIView *addView, NSString *text){
    [OkdeerHUD createHUDView:addView.bounds superView:addView tipText:text tipimage:nil];
}

/**
 在window上显示带图片的HUD
 
 @param image 需要显示的图片
 */
void showToastImageToWindow(UIImage *image, NSTimeInterval duration, void(^hideBlock)()){
    UIView *window = [OkdeerHUD fetchHudWindow];
    [OkdeerHUD createHUDView:[UIScreen mainScreen].bounds superView:window tipText:nil tipimage:image];
    //隐藏
    hideWindowLoadingDelay(duration, hideBlock);
}

/**
 隐藏window上创建的HUD
 */
bool hideLoadingFromWindow(){
    UIView *window = [OkdeerHUD fetchHudWindow];
    return [OkdeerHUD hideLoadingFromView:window];
}

/**
 延迟隐藏Window上的HUD
 
 @param duration 秒
 @param hideBlock 回调
 */
void hideWindowLoadingDelay(NSTimeInterval duration, void(^hideBlock)()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *window = [OkdeerHUD fetchHudWindow];
        BOOL hasHide =  [OkdeerHUD hideLoadingFromView:window];
        if (hasHide && hideBlock) {
            hideBlock();
        }
    });
}

/**
 隐藏指定view上创建的HUD
 
 @param view HUD的父视图
 */
bool hideLoadingFromView(UIView *view){
    return [OkdeerHUD hideLoadingFromView:view];
}

/**
 延迟隐藏UIView上的HUD
 
 @param duration 秒
 @param hideBlock 回调
 */
void hideViewLoadingDelay(UIView *view, NSTimeInterval duration, void(^hideBlock)()){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL hasHide = [OkdeerHUD hideLoadingFromView:view];
        if (hasHide && hideBlock) {
            hideBlock();
        }
    });
}

/**
 *  移除指定view上创建的HUD
 */
+ (BOOL)hideLoadingFromView:(UIView *)view
{
    for (UIView *hudView in view.subviews) {
        if ([hudView isKindOfClass:[OkdeerHUD class]]) {
            OkdeerHUD *hud = (OkdeerHUD *)hudView;
            hud.hideFlag = YES;
            [hud removeFromSuperview];
            return YES;
        }
    }
    return NO;
}

/**
 * HUD的window
 */
+ (UIView *)fetchHudWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark -===========初始化HUD===========

+(instancetype)createHUDView:(CGRect)frame
                   superView:(UIView *)superView
                     tipText:(NSString *)tipText
                    tipimage:(UIImage *)tipimage
{
    if (superView) {
        OkdeerHUD *hudView = [[OkdeerHUD alloc] initWithFrame:frame
                                                    superView:superView
                                                      tipText:tipText
                                                     tipimage:tipimage];
        [superView addSubview:hudView];
        [superView bringSubviewToFront:hudView];
        return hudView;
    } else {
        return nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView *)superView
                      tipText:(NSString *)tipText
                     tipimage:(UIImage *)tipimage
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.superView = superView;
        self.tipText = tipText;
        self.tipimage = tipimage;
        
        //初始化loadingView
        [self contentView];
        
        //开始动画
        [self zoomContentView:YES];
    }
    return self;
}

/**
 * 开始动画
 */
- (void)zoomContentView:(BOOL)zoomBig
{
    if (self.hideFlag) return;
    
    CGFloat zoomBigValue = 1.0;
    CGFloat zoomSmallValue = 1.0;
    if (zoomBig) {
        zoomBigValue = 1.1;
        zoomSmallValue = 0.8;
    } else {
        zoomBigValue = 0.8;
        zoomSmallValue = 1.1;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.firstRoundLayer.transform = CGAffineTransformMakeScale(zoomBigValue, zoomBigValue);
        self.secondRoundLayer.transform = CGAffineTransformMakeScale(zoomSmallValue, zoomSmallValue);
    } completion:^(BOOL finished) {
        if (finished) {
            [self zoomContentView:!zoomBig];
        }
    }];
}

/**
 *  设置layer
 */
- (UIView *)contentView
{
    if (!_contentView) {
        CGFloat contenHeight = kContentViewHeight;
        CGFloat contenWidth = kContentViewWidth;
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        _contentView.layer.cornerRadius = 5;
        
        if (self.tipimage) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:self.tipimage];
            imageView.contentMode = UIViewContentModeCenter;
            CGFloat imgY = (contenHeight-imageView.bounds.size.height)/2;
            CGFloat imgX = (contenWidth-imageView.bounds.size.width)/2;
            imageView.frame = CGRectMake(imgX , imgY, imageView.bounds.size.width, imageView.bounds.size.height);
            [_contentView addSubview:imageView];
            
        } else {
            CGFloat roundXSpace = (contenWidth-kLayerW*2)/3;
            CGFloat roundStartY = (contenHeight-kLayerH)/2;
            
            _firstRoundLayer = [[UIView alloc] init];
            _firstRoundLayer.frame = CGRectMake(roundXSpace+10, roundStartY, kLayerW, kLayerH);
            _firstRoundLayer.backgroundColor = UIColorFromHex(0xDF5356);
            _firstRoundLayer.layer.cornerRadius = kLayerH / 2;
            [_contentView addSubview:_firstRoundLayer];
            
            _secondRoundLayer = [[UIView alloc] init];
            _secondRoundLayer.frame = CGRectMake(CGRectGetMaxX(_firstRoundLayer.frame) + roundXSpace-15, roundStartY, kLayerW, kLayerH);
            _secondRoundLayer.backgroundColor = UIColorFromHex(0xECAB41);
            _secondRoundLayer.layer.cornerRadius = kLayerH / 2 ;
            [_contentView addSubview:_secondRoundLayer];
            
            if (self.tipText.length>0) {
                CGFloat startTextY = CGRectGetMaxY(_secondRoundLayer.frame) + kUIkitSpace;
                _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, startTextY, contenWidth, 16)];
                _textLabel.textAlignment = NSTextAlignmentCenter;
                _textLabel.textColor = [UIColor whiteColor];
                _textLabel.font = [UIFont systemFontOfSize:kTitleFont];
                _textLabel.numberOfLines = 2;
                _textLabel.text = self.tipText;
                [_textLabel sizeToFit];
                [_contentView addSubview:_textLabel];
                _textLabel.frame = CGRectMake(0, startTextY, contenWidth, _textLabel.frame.size.height);
                contenHeight = CGRectGetMaxY(_textLabel.frame) + roundStartY;
            }
        }
        _contentView.frame = CGRectMake(0, 0, contenWidth, contenHeight);
        [self addSubview:_contentView];
        _contentView.center = self.center;
    }
    return _contentView;
}

- (void)dealloc
{
    NSLog(@"OkdeerHUD dealloc");
}

@end
