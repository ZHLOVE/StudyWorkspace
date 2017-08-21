//
//  OKTagetSliderView.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/8/21.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKTagetSliderView : UIView

/** 标题数组 */
@property (nonatomic, strong) NSArray *titleArr;
/**图标数组 */
@property (nonatomic, strong) NSArray<UIImage *> *imageArr;
/** 线条样色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 标题颜色*/
@property (nonatomic, strong) UIColor *textClolr;
/** 点击按钮回调 */
@property (nonatomic, copy) void (^touchBtnBlock)(NSInteger actionTag);

/**
 * Badge数目
 */
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

/**
 * Badge数目
 */
- (void)setBadgeAtindex:(NSInteger)index badgeNum:(NSInteger)badgeNum;

@end

