//
//  NSNotification+OKExtention.h
//  OkdeerSeller
//
//  Created by 雷祥 on 17/3/2.
//  Copyright © 2017年 CloudCity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSNotification (OKExtension)

/**
 * 获取键盘高度
 */
- (CGFloat)ok_getKeyboardHeight;


/**
 快捷添加通知入口
 
 @param noteName 通知名称
 @param notifyBlcok 通知回调
 */
- (void)addObserverForName:(NSString *)noteName notifyBlcok:(void (^)(NSNotification *notify))notifyBlcok;


@end
