//
//  UIView+OKBadge.h
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/12.
//  Copyright © 2017年 OKDeer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBadgeBreatheAniKey     @"breathe"
#define kBadgeRotateAniKey      @"rotate"
#define kBadgeShakeAniKey       @"shake"
#define kBadgeScaleAniKey       @"scale"
#define kBadgeBounceAniKey      @"bounce"

//key for associative methods during runtime
static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeFontKey;
static char badgeTextColorKey;
static char badgeAniTypeKey;
static char badgeFrameKey;
static char badgeCenterOffsetKey;
static char badgeMaximumBadgeNumberKey;

typedef NS_ENUM(NSUInteger, WBadgeStyle)
{
    WBadgeStyleRedDot = 0,          /* red dot style */
    WBadgeStyleNumber,              /* badge with number */
    WBadgeStyleHollowNumber,        /* badge with number <背景是白色，红色边框> */
    WBadgeStyleNew                  /* badge with a fixed text "new" */
};

typedef NS_ENUM(NSUInteger, WBadgeAnimType)
{
    WBadgeAnimTypeNone = 0,         /* without animation, badge stays still */
    WBadgeAnimTypeScale,            /* scale effect */
    WBadgeAnimTypeShake,            /* shaking effect */
    WBadgeAnimTypeBounce,           /* bouncing effect */
    WBadgeAnimTypeBreathe           /* breathing light effect, which makes badge more attractive */
};


@interface UIView (OKBadge)

@property (nonatomic, strong) UILabel *badge;           
@property (nonatomic, strong) UIFont *badgeFont;		
@property (nonatomic, strong) UIColor *badgeBgColor;    
@property (nonatomic, strong) UIColor *badgeTextColor;  
@property (nonatomic, assign) CGRect badgeFrame;
@property (nonatomic, assign) CGPoint  badgeCenterOffset;
@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;

- (void)showBadgeWithStyle:(WBadgeStyle)style value:(NSInteger)value;

- (void)showBadge;

- (void)clearBadge;

- (void)resumeBadge;

@end

