//
//  NSNotification+OKExtention.m
//  OkdeerSeller
//
//  Created by 雷祥 on 17/3/2.
//  Copyright © 2017年 CloudCity. All rights reserved.
//

#import "NSNotification+OKExtension.h"

@implementation NSNotification (OKExtension)

/**
 * 获取键盘高度
 */
- (CGFloat)ok_getKeyboardHeight {
    NSDictionary *info = [self userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    return keyboardSize.height ;
}

/**
 *  快捷添加通知入口
 */
- (void)addObserverForName:(NSString *)noteName notifyBlcok:(void (^)(NSNotification *notify))notifyBlcok
{
    if (noteName.length==0 || ![noteName isKindOfClass:[NSString class]]) {
        NSLog(@"快捷添加通知失败通知名称不能为空===%@",noteName);
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserverForName:noteName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"快捷添加通知回调了: %@",noteName);
        if (notifyBlcok) {
            notifyBlcok(note);
        }
    }];
}


@end
