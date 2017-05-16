//
//  UILabel+Shortcut.m
//  OkdeerCommonLibrary
//
//  Created by mao wangxin on 2017/4/11.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "UILabel+OKShortcut.h"

@implementation UILabel (OKShortcut)


+ (UILabel *(^)(CGRect))initWithFrame {
    
    return ^UILabel * (CGRect rect) {
        UILabel * label = [[UILabel alloc] initWithFrame:rect];
        return label;
        
    };
}

- (UILabel * (^)(NSString *))ok_setText {
    
    return ^UILabel * (NSString * text) {        
        [self setText:text];
        return self;
    };
}

- (UILabel * (^)(UIFont *))ok_setFont {
    
    return ^UILabel * (UIFont * font) {
        [self setFont:font];
        return self;
    };
}

- (UILabel * (^)(UIColor *))ok_setTextColor {
    
    return ^UILabel * (UIColor * color) {
        [self setTextColor:color];
        return self;
    };
}

- (UILabel * (^)(UIColor *))ok_setBackgroundColor
{
    return ^UILabel *(UIColor * color){
        self.backgroundColor = color;
        return self;
    };
}

- (UILabel * (^)(UIColor *))ok_setShadowColor {
    
    return ^UILabel * (UIColor * color) {
        [self setShadowColor:color];
        return self;
    };
}


- (UILabel *(^)(UIColor *))ok_setBorderColor {
    
    return ^UILabel * (UIColor * color) {
        if (!self.layer.masksToBounds) {
            self.layer.masksToBounds = YES;
        }
        self.layer.borderColor = color.CGColor;
        return self;
    };
}

- (UILabel *(^)(CGFloat))ok_setBorderWidth {
    
    return  ^UILabel * (CGFloat force) {
        if (!self.layer.masksToBounds) {
            self.layer.masksToBounds = YES;
        }
        self.layer.borderWidth = force;
        return self;
    };
}

- (UILabel *(^)(CGFloat))ok_setCornerRadius {
    
    return  ^UILabel * (CGFloat force) {
        if (!self.layer.masksToBounds) {
            self.layer.masksToBounds = true;
        }
        self.layer.cornerRadius = force;
        return self;
    };
}

- (UILabel * (^)(CGSize))ok_setShadowOffset {
    
    return ^UILabel * (CGSize size) {
        [self setShadowOffset:size];
        return self;
    };
}

- (UILabel * (^)(NSTextAlignment))ok_setTextAlignment {
    
    return ^UILabel * (NSTextAlignment alignment) {
        [self setTextAlignment:alignment];
        return self;
    };
}

- (UILabel * (^)(NSLineBreakMode))ok_setLineBreakMode {
    
    return ^UILabel * (NSLineBreakMode mode) {
        [self setLineBreakMode:mode];
        return self;
    };
}

- (UILabel * (^)(NSAttributedString *))ok_setAttributedText {
    
    return ^UILabel * (NSAttributedString * attributed) {
        [self setAttributedText:attributed];
        return self;
    };
}

- (UILabel * (^)(UIColor *))ok_setHighlightedTextColor {
    
    return ^UILabel * (UIColor * color) {
        [self setHighlightedTextColor:color];
        return self;
    };
}

- (UILabel * (^)(BOOL))ok_setUserInteractionEnabled {
    
    return ^UILabel * (BOOL is) {
        [self setUserInteractionEnabled:is];
        return self;
    };
}

- (UILabel * (^)(BOOL))ok_setEnabled {
    
    return ^UILabel * (BOOL is) {
        [self setEnabled:is];
        return self;
    };
}

- (UILabel * (^)(NSInteger))ok_numberOfLines {
    
    return ^UILabel * (NSInteger number) {
        [self setNumberOfLines:number];
        return self;
    };
}

- (UILabel * (^)(UIView *))ok_addToView {
    
    return ^UILabel *(UIView *sub) {
        [sub addSubview:self];
        return self;
    };
}


@end

