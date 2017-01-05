//
//  UILabel+OKExtension.m
//  OkdeerUser
//
//  Created by mao wangxin on 2016/12/28.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "UILabel+OKExtension.h"

#define kFullScreenWidth           ([UIScreen mainScreen].bounds.size.width)

@implementation UILabel (OKExtension)


#pragma mark - ============ 设置按钮的属性文字 ============

/**
 *  设置属性文字
 *
 *  @param textArr   需要显示的文字数组,如果有换行请在文字中添加 "\n"换行符
 *  @param fontArr   字体数组, 如果fontArr与textArr个数不相同则获取字体数组中最后一个字体
 *  @param colorArr  颜色数组, 如果colorArr与textArr个数不相同则获取字体数组中最后一个颜色
 *  @param spacing   换行的行间距
 *  @param alignment 换行的文字对齐方式
 */
- (void)setAttriStrWithTextArray:(NSArray *)textArr
                         fontArr:(NSArray *)fontArr
                        colorArr:(NSArray *)colorArr
                     lineSpacing:(CGFloat)spacing
                       alignment:(NSTextAlignment)alignment
{
    if (textArr.count >0 && fontArr.count >0 && colorArr.count > 0) {
        
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
        
        //如果需要换行
        if ([allString rangeOfString:@"\n"].location != NSNotFound) {
            self.numberOfLines = 0;
        }
        
        self.attributedText = textAttr;
        
        //段落 <如果有换行 或者 字体宽度超过一行就设置行间距>
        if (self.frame.size.width > kFullScreenWidth || [allString rangeOfString:@"\n"].location != NSNotFound) {
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = spacing;
            paragraphStyle.alignment = alignment;
            self.numberOfLines = 0;
            [textAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,allString.length)];
            self.attributedText = textAttr;
        }
        [self sizeToFit];
        
    } else {
        self.text = @"文字,颜色,字体 每个数组至少有一个";
    }
}

@end
