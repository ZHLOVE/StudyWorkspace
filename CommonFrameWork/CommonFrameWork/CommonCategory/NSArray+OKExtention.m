//
//  NSArray+Extention.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSArray+OKExtention.h"
#import "NSObject+OKRuntime.h"

@implementation NSArray (OKExtention)
/**
 * 转化为字符串
 */
- (NSString *)ok_toString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)];
}


+ (void)load {
    [self ok_exchangeInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(ok_objectAtIndex:)];
}

/**
 * 获取数组的index值
 */
- (id)ok_objectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return [self ok_objectAtIndex:index];
    }
    else {
        NSLog(@"~~~~~~~~~~数组越界了哦~~~~~~~~~~");
        return nil;
    }
}


@end
