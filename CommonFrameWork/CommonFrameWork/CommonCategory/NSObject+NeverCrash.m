//
//  NSObject+NeverCrash.m
//  CommonFrameWork
//
//  Created by Luke on 2017/1/6.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "NSObject+NeverCrash.h"

@implementation NSObject (NeverCrash)

///**
// *  利用消息转发机制，做永不崩溃处理
// */
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//- (void)forwardInvocation:(NSInvocation *)invocation
//{
//    if ([self respondsToSelector:[invocation selector]]) {
//        [invocation invokeWithTarget:self];
//    }
//}
//#pragma clang diagnostic pop
//
//
///**
// *  利用消息转发机制，做永不崩溃处理
// */
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
//{
//    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:selector];
//    if(sig == nil) {
//        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
//    }
//    NSLog(@"处理异常崩溃场景===%@",NSStringFromSelector(selector));
//    return sig;
//}
#pragma clang diagnostic pop

@end
