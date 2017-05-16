//
//  NSObject+OKPrintModelProperty.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/2/28.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "NSObject+OKPrintModelProperty.h"

@implementation NSObject (OKPrintModelProperty)

/**
 * 根据字典模型打印出指定模型类的属性字符串
 *
 * @param dict 字典
 * @param className 模型类string
 */
+ (void)printModelPropertyWithDic:(NSDictionary *)dict modelClass:(NSString *)className
{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) return;
    
    if (!className || ![className isKindOfClass:[NSString class]]) {
        className = @"<#ClassName#>";
    }
    
    NSMutableString *allPropertyCode = [[NSMutableString alloc]init];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *oneProperty = [[NSString alloc]init];
        if ([obj isKindOfClass:[NSString class]]) {
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
            
        }else if ([obj isKindOfClass:[NSNumber class]]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
            
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;)",key];
            
        }else if ([obj isKindOfClass:[NSArray class]]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
            [self printArrayPropertyNameWithKey:key array:obj];
            
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
            [self printDictPropertyNameWithKey:key dict:obj];
        }
        
        [allPropertyCode appendFormat:@"\n/** <#属性注释#> */\n%@",oneProperty];
    }];
    
    NSString *classHeader = [NSString stringWithFormat:@"@interface %@ : NSObject",className];
    NSString *classFooter = @"@end";
    NSString *allStr= [NSString stringWithFormat:@"\n%@\n%@\n%@\n",classHeader,allPropertyCode,classFooter];
    const char *cString1 = [allStr cStringUsingEncoding:NSUTF8StringEncoding];
    printf("%s",cString1);
}


/**
 * 打印数组里面的字典属性名称
 */
+ (void)printArrayPropertyNameWithKey:(NSString *)key array:(NSArray *)arr
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *classStr = [NSString stringWithFormat:@"%@Model",key];
        [self printModelPropertyWithDic:arr[0] modelClass:classStr];
    });
}

/**
 * 打印字典里面的字典属性名称
 */
+ (void)printDictPropertyNameWithKey:(NSString *)key dict:(NSDictionary *)dic
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *classStr = [NSString stringWithFormat:@"%@Model",key];
        [self printModelPropertyWithDic:dic modelClass:classStr];
    });
}

@end

