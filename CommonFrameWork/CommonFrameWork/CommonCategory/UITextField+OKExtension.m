//
//  UITextField+OKExtension.m
//  基础框架类
//
//  Created by mao wangxin on 16/12/27.
//  Copyright © 2016年 leixiang. All rights reserved.
//

#import "UITextField+OKExtension.h"
#import "UIView+OKExtension.h"
#import "NSObject+OKRuntime.h"

@implementation UITextField (OKExtension)

/**
 * 这种方式设置不会恢复为默认属性，会保留设置的颜色文字大小等属性设置
 */
- (void)ok_setPlaceholder:(NSString *)placeholder {
    NSAttributedString *str = self.attributedPlaceholder;
    NSMutableAttributedString *attributestring = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [attributestring replaceCharactersInRange:NSMakeRange(0, attributestring.length) withString:placeholder];
    self.attributedPlaceholder = attributestring;
}


+ (void)load {
    //交换设置默认属性的方法，被替换的方法可以保留设置的文字属性。如果不替换设置的属性在重新赋值时会被设置成系统默认的属性
    [self ok_exchangeInstanceMethod:[self class] originSelector:@selector(setPlaceholder:) otherSelector:@selector(ok_setPlaceholder:)];
}


/**
 *  设置提示语的字体属性
 */
- (void)setupPlaceholder:(NSString *)placeholder attribute:(NSDictionary *)attributes;
{
    if (![attributes allKeys].count) {
        // 没有设置为默认
        self.placeholder = placeholder;
        return;
    }
    if (!placeholder) {
        placeholder = @"";
    }
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
}


- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;

    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;

    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range  // 备注：UITextField必须为第一响应者才有效
{
    UITextPosition* beginning = self.beginningOfDocument;

    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];

    [self setSelectedTextRange:selectionRange];
}
@end
