//
//  NSMutableArray+CCExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSMutableArray+OKExtension.h"
#import "NSObject+OKRuntime.h"

@implementation NSMutableArray (OKExtension)

+ (void)load {
    [self ok_exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(ok_objectAtIndex:)];
    [self ok_exchangeInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(insertObject:atIndex:) otherSelector:@selector(ok_insertObject:atIndex:)];
}

/**
 * 替换原生的`objectAtIndex`方法防止数据越界访问
 */
- (id)ok_objectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return [self ok_objectAtIndex:index];
    }
    return nil;
}

/**
 * 替换原生的`insertObject:`方法防止插入nil空数据
 */
- (void)ok_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (self.count >= index && anObject) {
        [self ok_insertObject:anObject atIndex:index];
    }
}


@end
