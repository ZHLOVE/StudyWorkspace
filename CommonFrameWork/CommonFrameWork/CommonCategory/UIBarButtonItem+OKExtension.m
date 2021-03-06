//
//  UIBarButtonItem+OKExtension.m
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UIBarButtonItem+OKExtension.h"
#import "OKPubilcKeyDefiner.h"
#import <OKColorDefiner.h>
#import "UIView+OKExtension.h"
#import <objc/runtime.h>
#import "NSString+OKExtention.h"

@implementation UIBarButtonItem (OKExtension)

/**
 * 通过appearance统一设置所有UITabBarItem的文字属性
 */
+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = FontSystemSize(12);
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = Color_BlackFont;
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateHighlighted];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title
                             titleColor:(UIColor *)color
                                 target:(id)target
                               selector:(SEL)selector
{
    color = color ? : [UIColor blackColor];    
    CGFloat width = [title widthWithFont:FontSystemSize(16) constrainedToHeight:20];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, width, 40);
    [addBtn setTitle:title forState:UIControlStateNormal];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addBtn setTitleColor:color forState:UIControlStateNormal];
    [addBtn setTitleColor:[color colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    addBtn.titleLabel.font = FontSystemSize(12);
    addBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    if (target && selector) {
        [addBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    return barButton;
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title
                             titleColor:(UIColor *)color
                             clickBlock:(dispatch_block_t)blk
{
    color = color ? : [UIColor blackColor];
    CGFloat width = [title widthWithFont:FontSystemSize(16) constrainedToHeight:20];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, width, 40);
    [addBtn setTitle:title forState:UIControlStateNormal];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addBtn setTitleColor:color forState:UIControlStateNormal];
    [addBtn setTitleColor:[color colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    addBtn.titleLabel.font = FontSystemSize(12);
    addBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:barButton action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(barButton, "UIBarButtonItem", blk, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return barButton;
}

+ (instancetype)itemWithImage:(UIImage *)image
                    highImage:(UIImage *)highImage
                       target:(id)target
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    highImage ? [button setBackgroundImage:highImage forState:UIControlStateHighlighted] : nil;
    button.size = button.currentBackgroundImage.size;
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                         highImage:(UIImage *)highImage
                        clickBlock:(dispatch_block_t)blk
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width+20, 40);
    [button setImage:image forState:UIControlStateNormal];
    highImage ? [button setImage:highImage forState:UIControlStateHighlighted] : nil;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    objc_setAssociatedObject(barButton, "UIBarButtonItem", blk, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [button addTarget:barButton action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    return barButton;
}

- (void)click
{
    dispatch_block_t blk = objc_getAssociatedObject(self, "UIBarButtonItem");
    if (blk) {
        blk();
    }
}


@end
