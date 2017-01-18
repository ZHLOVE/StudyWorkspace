//
//  NSObject+NeverCrash.m
//  CommonFrameWork
//
//  Created by Luke on 2017/1/6.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "NSObject+NeverCrash.h"

@implementation NSObject (NeverCrash)

/**
 *  利用消息转发机制，做永不崩溃处理
 */
- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

/**
 *  利用消息转发机制，做永不崩溃处理
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    NSLog(@"处理异常崩溃场景===%@",NSStringFromSelector(selector));
    return sig;
}

@end
