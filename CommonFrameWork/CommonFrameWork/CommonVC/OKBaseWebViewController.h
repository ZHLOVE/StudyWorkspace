//
//  OKBaseWebViewController.h
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKBaseWebViewController : OKBaseViewController

/** 加载url */
@property (nonatomic, copy) NSString *urlString;

/** 右侧按钮图标 */
@property (nonatomic, strong) UIImage *rightBtnImage;

/** 右侧按钮标题 */
@property (nonatomic, strong) NSString *rightBtnTitle;

/** 右侧按钮点击回调 */
@property (nonatomic, copy) void (^rightBtnBlock)(void);

@end
