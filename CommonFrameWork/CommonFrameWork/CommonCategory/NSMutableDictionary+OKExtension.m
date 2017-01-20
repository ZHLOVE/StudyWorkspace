//
//  NSMutableDictionary+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSMutableDictionary+OKExtension.h"
#import "NSObject+OKRuntime.h"

@implementation NSMutableDictionary (OKExtension)
+ (void)load
{
    [self ok_exchangeInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setObject:forKey:) otherSelector:@selector(ok_setObject:forKey:)];
}

- (void)ok_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!anObject || !aKey) return;

    [self ok_setObject:anObject forKey:aKey];
}


@end
