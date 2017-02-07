//
//  UIButton+OKExtension.m
//  SendHttpDemo
//
//  Created by mao wangxin on 2016/12/28.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "UIButton+OKExtension.h"
#import "UIImage+OKExtension.h"
#import <objc/runtime.h>

#define UIColorFromHex(hexValue) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:1.0])

#define OK_Btn_NormalColor          UIColorFromHex(0x8CC63F)
#define OK_Btn_HighlightedColor     [OK_Btn_NormalColor colorWithAlphaComponent:0.4]
#define OK_Btn_DisabledColor        UIColorFromHex(0xdcdcdc)

static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (OKExtension)

#pragma mark - ============ 统一大按钮样式 ============

/**
 统一带园角的大按钮样式
 
 @param supview   父视图
 @param rect      在父位置
 @param title     标题
 @param img       图片
 @param blk       点击回调
 @return          返回该按钮
 */
+ (instancetype)bigBtnToView:(UIView *)supview
                       frame:(CGRect)rect
                       title:(NSString *)str
                       image:(UIImage *)img
                  clickBlock:(void (^)(UIButton *button))blk
{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setBackgroundImage:[UIImage ok_imageWithColor:OK_Btn_NormalColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage ok_imageWithColor:OK_Btn_HighlightedColor] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage ok_imageWithColor:OK_Btn_DisabledColor] forState:UIControlStateDisabled];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHex(0xa4a4a4) forState:UIControlStateDisabled];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn setImage:img forState:UIControlStateNormal];
    if (blk) {
        __weak UIButton *button = btn;
        [btn addTouchUpInsideHandler:^(UIButton *btn) {
            blk(button);
        }];
    }
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    [supview addSubview:btn];
    return btn;
}

#pragma mark - ============ 按钮开始倒计时 ============

/**
 按钮开始倒计时

 @param time     倒计时时间
 @param norTitle 普通状态时标题
 @param selTitle 高亮状态时标题
 @param norColor 普通状态时标题颜色
 @param selColor 高亮状态时标题颜色
 @param blcok    倒计时完成Block回调
 */
- (dispatch_source_t)startWithTime:(NSInteger)time
       btnNormalTitle:(NSString *)norTitle
        selectedTitle:(NSString *)selTitle
          normalColor:(UIColor *)norColor
        selectedColor:(UIColor *)selColor
        completeBlock:(void(^)())blcok
{
    __block NSInteger timeOut = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setBackgroundColor:norColor forState:UIControlStateNormal];
                [self setTitle:norTitle forState:UIControlStateNormal];
                if (blcok) { //倒计时完成
                    blcok();
                }
            });
        } else {
            int allTime = (int)time + 1;
            int seconds = timeOut % allTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                NSString *title = [NSString stringWithFormat:@"%@%dS",selTitle,seconds];
                [self setBackgroundColor:selColor forState:UIControlStateDisabled];
                [self setTitle:title forState:UIControlStateDisabled];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    return _timer;
}

#pragma mark - ============ 给按钮点击事件 ============

/**
 按钮点击以Block方式回调
 
 @param handler 点击事件的回调
 */
-(void)addTouchUpInsideHandler:(TouchedBlock)handler
{
    objc_setAssociatedObject(self, UIButtonBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(cc_touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)cc_touchUpInsideAction:(UIButton *)btn{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn);
    }
}

#pragma mark - ============ 设置按钮不同状态的背景颜色 ============

/**
 *  设置按钮不同状态的背景颜色（代替图片）
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIImage ok_imageWithColor:backgroundColor] forState:state];
}

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
            self.titleLabel.numberOfLines = 0;
        }
        
        [self setAttributedTitle:textAttr forState:0];
        
        //段落 <如果有换行 或者 字体宽度超过一行就设置行间距>
        if (self.frame.size.width > [UIScreen mainScreen].bounds.size.width || [allString rangeOfString:@"\n"].location != NSNotFound) {
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = spacing;
            paragraphStyle.alignment = alignment;
            self.titleLabel.numberOfLines = 0;
            [textAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,allString.length)];
            [self setAttributedTitle:textAttr forState:0];
            [self sizeToFit];
        }
        
    } else {
        [self setTitle:@"文字,颜色,字体 每个数组至少有一个" forState:0];
    }
}

#pragma mark - ============ 布局标题和图片位置 ============

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutImageOrTitleEdgeInsets:(OKButtonEdgeInsetsStyle)style
                     imageTitleSpace:(CGFloat)space
{    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case OKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case OKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case OKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case OKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
