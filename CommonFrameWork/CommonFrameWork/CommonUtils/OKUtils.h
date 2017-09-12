//
//  OKUtils.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OKUtils : NSObject


/*
 * 替换字符串中的双引号
 */
+ (NSString *)replaceShuangyinhao:(NSString *)values;

#pragma 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

#pragma 正则匹配昵称
+ (BOOL) checkNickname:(NSString *) nickname;

#pragma 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *) nickNumber;

#pragma 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *) nickNumber;

#pragma 正则匹配银行卡号是否正确
+ (BOOL) checkBankNumber:(NSString *) bankNumber;

#pragma 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber;

#pragma 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber;

#pragma 车牌号验证
+ (BOOL) checkCarNumber:(NSString *) CarNumber;

#pragma mark 是否包含中文
+(BOOL)CheckContainChinese:(NSString *)chinese;

/**
 * 判断是否是有效价格
 */
+ (BOOL)ok_validPrice:(NSString *)text;

/**
 * 是否是正数
 */
+ (BOOL)ok_isPositiveNumber:(NSString *)text;

/**
 * 对特殊字符编码(不包含#)
 */
+ (NSString *)ok_urlStringEncoding:(NSString *)text;

/**
 * 对参数进行编码
 */
+ (NSString *)ok_parameterEncoding:(NSString *)text;

/**
 *  判断是不是http字符串（在传图片时，判断是本地图片或者是网络图片）
 */
+ (BOOL)ok_isHttpString:(NSString *)text;

/**
 *  去除emoji表情
 */
+ (NSString *)ok_toString:(id)obj;

/**
 *  格式化价格,是小数就保留两位,不是小数就取整数
 */
+ (NSString *)formatPriceValue:(CGFloat)originValue;

/**
 * 时间格式实现几天前，几小时前，几分钟前, (类似于微博时间)
 */
+ (NSString *)compareCurrentTime:(NSString *)str;

/**
 * 获取今天是星期几
 */
+ (NSString *) getweekDayStringWithDate:(NSDate *) date;

@end
