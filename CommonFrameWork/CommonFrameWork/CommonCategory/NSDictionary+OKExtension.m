//
//  NSDictionary+Extention.m
//  基础框架类
//
//  Created by 雷祥 on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSDictionary+OkExtension.h"

@implementation NSDictionary (OkExtension)


/**
 * 转化为字符串
 */
- (NSString *)ok_toString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)];
}



@end
