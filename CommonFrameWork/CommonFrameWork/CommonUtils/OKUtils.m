//
//  OKUtils.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKUtils.h"

@implementation OKUtils

/*
 替换字符串中的双引号
 注：将字符串中的参数进行替换
 参数1：目标替换值
 参数2：替换成为的值
 参数3：类型为默认：NSLiteralSearch
 参数4：替换的范围
 */
+ (NSString *)replaceShuangyinhao:(NSString *)values
{
    if (!values || ![values isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    NSMutableString *temp = [NSMutableString stringWithString:values];
    [temp replaceOccurrencesOfString:@"\"" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    return temp;
}

/**
 * 正则匹配邮箱号
 */
+ (BOOL)checkMailInput:(NSString *)mail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}

/**
 * 正则匹配手机号
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,183,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:telNumber] == YES)
        || ([regextestcm evaluateWithObject:telNumber] == YES)
        || ([regextestct evaluateWithObject:telNumber] == YES)
        || ([regextestcu evaluateWithObject:telNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 * 正则匹配用户密码6-18位数字和字母组合
 */
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

/**
 * 正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)checkUserName : (NSString *) userName
{
    //    NSString *pattern = @"^[A-Za-z0-9]{6,20}+$";
    NSString *pattern = @"^([\u4e00-\u9fa5]+|([a-zA-Z]+\\s?)+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

/**
 * 正则匹配用户身份证号15或18位
 */
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    BOOL flag;
    if (idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

/**
 * 正则匹员工号,12位的数字
 */
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

/**
 * 正则匹配URL
 */
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

/**
 * 正则匹配昵称
 */
+ (BOOL) checkNickname:(NSString *) nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

/**
 * 正则匹配以C开头的18位字符
 */
+ (BOOL) checkCtooNumberTo18:(NSString *) nickNumber
{
    NSString *nickNum=@"^C{1}[0-9]{18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}

/**
 * 正则匹配以C开头字符
 */
+ (BOOL) checkCtooNumber:(NSString *) nickNumber
{
    NSString *nickNum=@"^C{1}[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}

/**
 * 正则匹配银行卡号是否正确
 */
+ (BOOL) checkBankNumber:(NSString *) bankNumber{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;
}

/**
 * 正则匹配17位车架号
 */
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^(\\d{17})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}

/**
 * 正则只能输入数字和字母
 */
+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}

/**
 * 车牌号验证
 */
+ (BOOL) checkCarNumber:(NSString *) CarNumber{
    NSString *bankNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CarNumber];
    return isMatch;
}

/**
 * 是否包含中文
 */
+(BOOL)CheckContainChinese:(NSString *)chinese
{
    for(int i=0; i< [chinese length];i++) {
        int a = [chinese characterAtIndex:i];
        if( a > 0x4E00 && a < 0x9FFF) {
            return YES;
        }
    }
    return NO;
}

/**
 * 判断是否是有效价格
 */
+ (BOOL)ok_validPrice:(NSString *)text {
    NSString *regex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:text];
    
}

/**
 * 是否是正数
 */
+ (BOOL)ok_isPositiveNumber:(NSString *)text {
    NSString *regex = @"^[1-9][0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:text];
}


//对特殊字符编码(不包含#)
+ (NSString *)ok_urlStringEncoding:(NSString *)text {
    NSCharacterSet *uRLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"+<>[\\]^`{|}"] invertedSet];
    return [text stringByAddingPercentEncodingWithAllowedCharacters:uRLCombinedCharacterSet];
}

//对参数进行编码
+ (NSString *)ok_parameterEncoding:(NSString *)text {
    NSCharacterSet *uRLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"+%<>[\\]^`{|}/"] invertedSet];   //对"%"和"／"进行了编码
    return [text stringByAddingPercentEncodingWithAllowedCharacters:uRLCombinedCharacterSet];
}

/**
 *  判断是不是http字符串（在传图片时，判断是本地图片或者是网络图片）
 *  @return BOOL
 */
+ (BOOL)ok_isHttpString:(NSString *)text{
    
    NSString *httpStrRegex = @"^http[s]{0,1}://.+";
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:httpStrRegex options:0 error:nil];
    NSArray *array = [regular matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    return array.count ;
}

/**
 *  去除emoji表情
 *
 *  返回NSString字符串
 */
+ (NSString *)ok_toString:(id)obj
{
    if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        }
        
        if (![obj isKindOfClass:[NSNull class]] && ![obj isEqual:nil] && ![obj isEqual:[NSNull null]]) {
            NSString *result = [NSString stringWithFormat:@"%@",obj];
            if (result && result.length > 0) {
                return result;
            }
            else{
                return @"";
            }
        }
        else{
            return @"";
        }
    }
    else{
        return @"";
    }
}

/**
 *  格式化价格,是小数就保留两位,不是小数就取整数
 */
+ (NSString *)formatPriceValue:(CGFloat)originValue
{
    //取浮点型的整数位的价格
    CGFloat intValue = floor(originValue);
    NSString *formatValue = nil;
    if ((originValue-intValue) > 0) {//如果不是整数就显示两位
        formatValue = [NSString stringWithFormat:@"%.2f",originValue];
    } else {
        formatValue = [NSString stringWithFormat:@"%.0f",originValue];
    }
    return formatValue;
}

/**
 * 时间格式实现几天前，几小时前，几分钟前, (类似于微博时间)
 */
+ (NSString *)compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

/**
 * 获取今天是星期几
 */
+ (NSString *) getweekDayStringWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString = @"(星期一)";
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"(星期日)";
        }
            break;
            
        case 2:
        {
            weekDayString = @"(星期一)";
        }
            break;
            
        case 3:
        {
            weekDayString = @"(星期二)";
        }
            break;
            
        case 4:
        {
            weekDayString = @"(星期三)";
        }
            break;
            
        case 5:
        {
            weekDayString = @"(星期四)";
        }
            break;
            
        case 6:
        {
            weekDayString = @"(星期五)";
        }
            break;
            
        case 7:
        {
            weekDayString = @"(星期六)";
        }
            break;
            
        default:
            break;
    }
    return weekDayString;
    
}

@end
