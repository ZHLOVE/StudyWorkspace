//
//  NSString+Extention.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/26.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "NSString+OKExtention.h"
#import <UIKit/UIKit.h>

@implementation NSString (OKExtention)
/**
 * 判断是否包含
 */
-(BOOL)ok_containsString:(NSString *)str {
    //不是字符串
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }

    if ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0) {
        return [self containsString:str];
    }
    else {
        NSRange range = [str rangeOfString:self];
        if (range.location == NSNotFound) {
            return NO;
        }
        else {
            return YES;
        }
    }
}

/**
 * 是否时有效的范围
 */
- (BOOL)ok_isValidRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        return NO;
    }
    else {
        return YES;
    }
}

/**
 * 字符串长度是否在给定的range范围内
 */
- (BOOL)ok_lengthInRange:(NSRange)range {
    if (self.length >= range.location && self.length <= (range.location + range.length)) {
        return YES;
    }
    else {
        return NO;
    }
}

/**
 * 转化为字典
 */
- (NSDictionary *)jsonToDictionary {
    NSData *jsonData = [self dataUsingEncoding:(NSUTF8StringEncoding)];
    NSError *errer;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&errer];
    if (errer) {
        return nil;
    }

    return dic;
}

- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.height);
}

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.width);
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

+ (NSString *)reverseString:(NSString *)strSrc
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}


+ (NSString *)jointWithFileName:(NSString *)fileName newExtension:(NSString *)newName{
    NSString* name = [fileName stringByDeletingPathExtension];
    NSString* extensionName = [fileName pathExtension];
    
    return [NSString stringWithFormat:@"%@%@.%@",name,newName,extensionName];
}

/**
 *  获取属性文字
 *
 *  @param textArr   需要显示的文字数组,如果有换行请在文字中添加 "\n"换行符
 *  @param fontArr   字体数组, 如果fontArr与textArr个数不相同则获取字体数组中最后一个字体
 *  @param colorArr  颜色数组, 如果colorArr与textArr个数不相同则获取字体数组中最后一个颜色
 *  @param spacing   换行的行间距
 *  @param alignment 换行的文字对齐方式
 */
+ (NSMutableAttributedString *)getAttriStrByTextArray:(NSArray *)textArr
                                              fontArr:(NSArray *)fontArr
                                             colorArr:(NSArray *)colorArr
                                          lineSpacing:(CGFloat)spacing
                                            alignment:(NSTextAlignment)alignment
{
    //文字,颜色,字体 每个数组至少有一个
    if (textArr.count > 0 || fontArr.count>0 || colorArr.count>0) return nil;
    
    NSMutableString *allString = [NSMutableString string];
    for (NSString *tempText in textArr) {
        [allString appendFormat:@"%@",tempText];
    }
    
    NSRange lastTextRange = NSMakeRange(0, 0);
    NSMutableArray *rangeArr = [NSMutableArray array];
    
    for (NSString *tempText in textArr) {
        NSRange range = [allString rangeOfString:tempText];
        
        //如果存在相同字符,则换一种查找的方法
        if ([allString componentsSeparatedByString:tempText].count>2) { //存在多个相同字符
            range = NSMakeRange(lastTextRange.location+lastTextRange.length, tempText.length);
        }
        
        [rangeArr addObject:NSStringFromRange(range)];
        lastTextRange = range;
    }
    
    //设置属性文字
    NSMutableAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithString:allString];
    for (int i=0; i<textArr.count; i++) {
        NSRange range = NSRangeFromString(rangeArr[i]);
        
        UIFont *font = (i > fontArr.count-1) ? [fontArr lastObject] : fontArr[i];
        [textAttr addAttribute:NSFontAttributeName value:font range:range];
        
        UIColor *color = (i > colorArr.count-1) ? [colorArr lastObject] : colorArr[i];
        [textAttr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    //段落 <如果有换行>
    if ([allString rangeOfString:@"\n"].location != NSNotFound && spacing>0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = spacing;
        paragraphStyle.alignment = alignment;
        [textAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,allString.length)];
    }
    
    return textAttr;
}

@end
