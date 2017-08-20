//
//  OKShareView.h
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKShareView : UIView

/**
 分享视图

 @param title 标题(支持NSString ,NSAttributedString)
 @param titleArr 分享图标标题
 @param imageArr 分享图标图片
 @param callBlock 选择回调
 @return 分享视图实例
 */
+ (instancetype)showShareViewWithTitle:(id)title
                          itemTitleArr:(NSArray<NSString *> *)titleArr
                          itemImageArr:(NSArray<UIImage *> *)imageArr
                             callBlock:(void(^)(NSInteger buttonIndex))callBlock;

@end
