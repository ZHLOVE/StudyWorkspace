//
//  NSString+OKEncryption.h
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OKEncryption)
#pragma mark --- md5
/**
 *  md5加密
 *
 *  @param inPutText 加密的数据
 */
+(NSString *) md5: (NSString *) inPutText;
/**
 *  md5加盐
 *
 *  @param inPutText 加密的数据
 *  @param key 盐值
 */
+ (NSString *)md5Todigest2:(NSString *)inPutText key:(NSString *)key;
#pragma mark --- des
/**
 *  des加密
 *
 *  @param sText 加密数据
 *  @param key   加密的key
 *
 *  @return 返回加密后的数据
 */
+ (NSString *)encryptWithText:(NSString *)sText key:(NSString *)key;
/**
 *  des解密
 *
 *  @param sText 解密数据
 *  @param key   解密的key
 *
 *  @return 返回解密之后的数据
 */
+ (NSString *)decryptWithText:(NSString *)sText key:(NSString *)key;
@end
