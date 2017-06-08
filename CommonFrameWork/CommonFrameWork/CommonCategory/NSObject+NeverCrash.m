//
//  NSObject+NeverCrash.m
//  CommonFrameWork
//
//  Created by Luke on 2017/1/6.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "NSObject+NeverCrash.h"
#import <objc/message.h>

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
//#pragma clang diagnostic pop

@end

@implementation NSObject (OKKVC)
+ (void)load {
    Method otherMethodOfGet = class_getClassMethod([self class], @selector(ok_valueForUndefinedKey:));
    Method originMethodOfGet = class_getClassMethod([self class], @selector(valueForUndefinedKey:));
    method_exchangeImplementations(originMethodOfGet, otherMethodOfGet);
    
    Method otherMethodOfSet = class_getClassMethod([self class], @selector(ok_setValue:forUndefinedKey:));
    Method originMethodOfSet = class_getClassMethod([self class], @selector(setValue:forUndefinedKey:));
    method_exchangeImplementations(otherMethodOfSet, originMethodOfSet);
}

- (id)ok_valueForUndefinedKey:(NSString *)key{
    NSLog(@"❌❌❌ < %@ > 类中当前属性 key: %@ 没有值",[self class], key);
    return nil;
}

- (void)ok_setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"❌❌❌ < %@ > 类中没有该属性 key: %@",[self class], key);
}

@end
