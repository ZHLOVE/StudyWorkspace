//
//  NSString+OKEncryption.m
//  基础框架类
//
//  Created by 雷祥 on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSString+OKEncryption.h"
#include <sys/xattr.h>
#import <objc/runtime.h>
#import "CommonCrypto/CommonDigest.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "GTMDefines.h"

@implementation NSString (OKEncryption)
/**
 *  md5加密
 *
 *  @param inPutText 加密的数据
 */
+(NSString *) md5: (NSString *) inPutText{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);

    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
/**
 *  md5加盐
 *
 *  @param inPutText 加密的数据
 *  @param key 盐值
 */
+ (NSString *)md5Todigest2:(NSString *)inPutText key:(NSString *)key{
    inPutText = [NSString stringWithFormat:@"%@%@",inPutText,key];
    return [self md5:inPutText];
}
#pragma mark --- des
/**
 *  des加密
 *
 *  @param sText 加密数据
 *  @param key   加密的key
 *
 *  @return 返回加密后的数据
 */
+ (NSString *)encryptWithText:(NSString *)sText key:(NSString *)key{
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:key];
}
/**
 *  des解密
 *
 *  @param sText 解密数据
 *  @param key   解密的key
 *
 *  @return 返回解密之后的数据
 */
+ (NSString *)decryptWithText:(NSString *)sText key:(NSString *)key{
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:key];
}
/**
 *  des 加密解密的方法
 *
 *  @param sText            加密、解密数据
 *  @param encryptOperation 类型  是加密 还是解密
 *  @param key              加密、解密的key
 *
 *  @return 返回加密、解密后的数据
 */
+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *dataIn;
    size_t dataInLength;

    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }

    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;

    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0

    NSString *initIv = key;
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [initIv UTF8String];

    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(encryptOperation,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    NSString *result = nil;

    if (ccStatus == kCCSuccess) {
        NSLog(@"加密成功");
    }
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }
    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];

        result = [GTMBase64 stringByEncodingData:data];
    }

    return result;
}
@end
