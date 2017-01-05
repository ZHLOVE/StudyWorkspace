//
//  NSNull+OKSafely.m
//  OkdeerUser
//
//  Created by mao wangxin on 2016/11/24.
//  Copyright © 2016年 OkdeerUser. All rights reserved.
//

#import "NSNull+OKSafely.h"

@implementation NSNull (OKSafely)

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end
