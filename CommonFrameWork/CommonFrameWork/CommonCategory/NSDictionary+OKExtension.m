//
//  NSDictionary+Extention.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSDictionary+OKExtension.h"

@implementation NSDictionary (OkExtension)


/**
 * 转化为字符串
 */
- (NSString *)ok_toString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)];
}


/**
 * 根据字典模型打印出指定模型类的属性字符串
 *
 * @param className 模型类string
 */
- (void)printPropertyWithClassName:(NSString *)className
{
#ifdef DEBUG
    //1.打印所有需要导入的 `@class`类
    [self printAllGuideClass];
    
    //打印所有的 `@interface` 、`@property` 、 `@end`
    [self printAllPropertyString:className];
#endif
}


/**
 * 打印所有需要导入的 `class`类
 */
- (void)printAllGuideClass
{
    if (((NSDictionary *)self).allKeys.count == 0) return;
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]] ||
            [obj isKindOfClass:[NSArray class]]){
            
            NSString *allStr = [NSString stringWithFormat:@"\n@class %@;",key.capitalizedString];
            const char *cString1 = [allStr cStringUsingEncoding:NSUTF8StringEncoding];
            printf("%s",cString1);
            
            //打印所有子结构体需要导入的 `class`类
            if ([obj isKindOfClass:[NSArray class]]) {
                
                NSArray *arr = ((NSArray *)obj);
                if (arr.count > 0) {
                    NSDictionary *dic = (NSDictionary *)arr[0];
                    if ([dic isKindOfClass:[NSDictionary class]] && dic.count > 0) {
                        [dic printAllGuideClass];
                    }
                }
            } else {
                [obj printAllGuideClass];
            }
        }
    }];
}


/**
 * 打印所有的 `interface` 和 `end`
 */
- (void)printAllPropertyString:(NSString *)className
{
    if (((NSDictionary *)self).allKeys.count == 0) return;
    
    if (!className || ![className isKindOfClass:[NSString class]] || className.length==0) {
        className = @"<#❌❌❌: 类名#>";
    }
    
    NSMutableString *allPropertyBody = [[NSMutableString alloc]init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *oneProperty = [[NSString alloc]init];
        if ([obj isKindOfClass:[NSString class]]) {
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
            
        } else if ([obj isKindOfClass:[NSNumber class]]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
            
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;)",key];
            
        } else if ([obj isKindOfClass:[NSArray class]]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray<%@ *> *%@;",key.capitalizedString, key];
            
            //打印数组里面的字典属性名称
            NSArray *arr = (NSArray *)obj;
            if (arr.count > 0) {
                NSDictionary *dic = (NSDictionary *)arr[0];
                //注意：如果数组中装的是不同的结构体类型，则不能成功打印
                if ([dic isKindOfClass:[NSDictionary class]] && dic.count > 0) {
                    [dic printAllPropertyString:key.capitalizedString];
                }
            }
        } else if ([obj isKindOfClass:[NSDictionary class]]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",key.capitalizedString, key];
            
            //打印字典里面的字典属性名称
            NSDictionary *dic = (NSDictionary *)obj;
            if (dic.count > 0) {
                [dic printAllPropertyString:key.capitalizedString];
            }
        }
        
        [allPropertyBody appendFormat:@"\n/** <#属性注释#> */\n%@",oneProperty];
    }];
    
    NSString *classHeader = [NSString stringWithFormat:@"@interface %@ : NSObject",className];
    NSString *classFooter = @"@end\n";
    NSString *allStr= [NSString stringWithFormat:@"\n%@\n%@\n%@\n",classHeader,allPropertyBody,classFooter];
    const char *cString1 = [allStr cStringUsingEncoding:NSUTF8StringEncoding];
    printf("%s",cString1);
}

@end
