//
//  OKChooseDateView.m
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKChooseDateView.h"
#import "UIView+OKExtension.h"
#import "OKPubilcKeyDefiner.h"
#import "OKFrameDefiner.h"
#import "OKColorDefiner.h"
#import "OKCFunction.h"
#import "OKAlertView.h"

#define Blue_Color              UIColorFromHex(0x007aff)
#define Text_Color              UIColorFromHex(0x323232)
//确定Btn
#define EnsureBtn               ((UIButton *)[_bgView viewWithTag:7778])
//取消Btn
#define CancelBtn               ((UIButton *)[_bgView viewWithTag:7777])
//开始时间Btn
#define StartBtn                ((OKDateButton *)[_bgView viewWithTag:8888])
//结束时间Btn
#define EndBtn                  ((OKDateButton *)[_bgView viewWithTag:8889])
// H:M 样式
#define OKChooseTimeModel       (UIDatePickerModeTime)
// 时间戳
#define OKChooseCurrentDate     (OKChooseTimeModel == self.okDatePicker.datePickerMode?dateFromString(@"2015-06-06 07:00:00"):[self getCurrentDate])
#define OKChooseEndCurrentDate  (OKChooseTimeModel == self.okDatePicker.datePickerMode?dateFromString(@"2015-06-06 23:00:00"):[self getCurrentDate])

#define DEFAULT_H_Single        (self.isSingleSelect?1:2)
#define DEFAULT_H               (44.5*DEFAULT_H_Single+216)

@interface OKDateButton : UIButton
@end

@implementation OKDateButton

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if ([self.titleLabel.attributedText.string isEqualToString:@"开始时间"]||[self.titleLabel.attributedText.string isEqualToString:@"结束时间"]) {
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.attributedText.string];
        if (self.isSelected) {
            [mStr setAttributes:@{NSFontAttributeName:FONTSYSTEM(14),NSForegroundColorAttributeName:Color_Main} range:NSMakeRange(0, 4)];
        }
        else
        {
            [mStr setAttributes:@{NSFontAttributeName:FONTSYSTEM(14),NSForegroundColorAttributeName:UIColorFromHex(0xa4a4a4)} range:NSMakeRange(0, 4)];
        }
        [self setAttributedTitle:mStr forState:UIControlStateNormal];
    }
}

@end

@interface OKChooseDateView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) UIDatePickerMode mode;
@property (nonatomic, copy) NSString *startDate,*endDate;
@property (nonatomic, assign)CGPoint touchPoint;
@property (nonatomic, copy) void (^block)(NSString *,NSString *,BOOL);
@property (nonatomic, assign)BOOL isSingleSelect;
@property (nonatomic, copy) void (^singleBlock)(NSString *,BOOL);
@end

@implementation OKChooseDateView

#pragma mark - LifeCycle
/**
 选择时间控件
 
 @param dateViewStyle 时间控件样式
 @param startDate 开始时间
 @param endDate 结束时间
 @param block 选择回调
 @return 时间控件实例
 */
+(instancetype)showViewWithStyle:(OKChooseDateViewStyle)dateViewStyle
                       startDate:(NSString *)startDate
                         endDate:(NSString *)endDate
                    callBackHand:(void (^)(NSString *chooseStartDate, NSString *chooseEndDate, BOOL flag))block
{
    switch (dateViewStyle)
    {
        case OKYMDStyle:
        {
            OKChooseDateView * dateView = [[self alloc]initWithPickModel:UIDatePickerModeDate
                                                             AdStartDate:startDate
                                                               AdEndDate:endDate
                                                          SelectionBlock:block];
            [dateView show];
            return dateView;
        }
        case OKHMStyle:
        {
            OKChooseDateView * dateView = [[self alloc]initWithPickModel:OKChooseTimeModel
                                                             AdStartDate:startDate
                                                               AdEndDate:endDate
                                                          SelectionBlock:block];
            [dateView show];
            return dateView;
        }
        default:
            break;
    }
    return nil;
}

- (instancetype)initWithPickModel:(UIDatePickerMode)pickMode
                      AdStartDate:(NSString *)startDate
                        AdEndDate:(NSString *)endDate
                   SelectionBlock:(void (^)(NSString *startDate,NSString *endDate,BOOL))block
{
    if (self = [super init])
    {
        self.alpha = 0.0;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        self.mode = pickMode;
        self.block = [block copy];
        self.frame = [[UIScreen mainScreen] bounds];
        [self createContentView:pickMode AdStartDate:startDate AdEndDate:endDate];
    }
    return self;
}


+(instancetype)showWithSingleSelectionBlock:(void (^)(NSString * ,BOOL))block
{
    OKChooseDateView * dateView = [[self alloc]initWithSinglePickModel:UIDatePickerModeDate SelectionBlock:block];
    [dateView show];
    return dateView;
}

-(instancetype)initWithSinglePickModel:(UIDatePickerMode)pickMode SelectionBlock:(void (^)(NSString * ,BOOL))block
{
    if (self = [super init])
    {
        self.alpha = 0.0;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        self.mode = pickMode;
        self.singleBlock = [block copy];
        self.frame = [[UIScreen mainScreen] bounds];
        self.isSingleSelect = YES;
        [self createContentView:pickMode AdStartDate:nil AdEndDate:nil];
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - Initialize
- (UIWindow *)bgWindow
{
    UIWindow *bgWindow = [UIApplication sharedApplication].delegate.window;
    return bgWindow;
}

-(void)createContentView:(UIDatePickerMode)pickMode AdStartDate:(NSString *)startDate AdEndDate:(NSString *)endDate
{
    //背景dismis事件
    UIControl *control = [[UIControl alloc]initWithFrame:self.frame];
    [control addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, 44.5*DEFAULT_H_Single+216)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:i==0?@"取消":@"确定" forState:UIControlStateNormal];
        if (i==0) {
            btn.center = CGPointMake(22, 22);
            btn.bounds = CGRectMake(0, 0, 44, 44);
            [btn setTitleColor:Text_Color forState:UIControlStateNormal];
            [btn setTitleColor:[Text_Color colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
            [btn setTitleColor:[Text_Color colorWithAlphaComponent:0.1] forState:UIControlStateDisabled];
        }
        if (i==1) {
            btn.center = CGPointMake(Screen_Width-22, 22);
            btn.bounds = CGRectMake(0, 0, 44, 44);
            [btn setTitleColor:Color_Main forState:UIControlStateNormal];
            [btn setTitleColor:[Color_Main colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
            [btn setTitleColor:Color_DisableBtn forState:UIControlStateDisabled];
        }
        btn.tag = 7777+i;
        [btn.titleLabel setFont:FONTSYSTEM(14)];
        if (i==1&&!self.isSingleSelect) {
            btn.enabled = NO;
        }
        [_bgView addSubview:btn];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        // 单选样式
        if (self.isSingleSelect) continue;
        
        CGFloat width = _bgView.width/2.f-0.25;
        OKDateButton *btnDown = [OKDateButton buttonWithType:UIButtonTypeCustom];
        btnDown.titleLabel.numberOfLines = 0;
        btnDown.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setBtn:btnDown withTitle:i==0?@"开始时间":@"结束时间" AdSelect:NO];
        btnDown.frame = CGRectMake(i==0?0:width+0.5, _bgView.height-44, width, 44);
        btnDown.tag = 8888+i;
        [_bgView addSubview:btnDown];
        [btnDown addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!self.isSingleSelect)
    {
        for (int i = 0; i < 4; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5*i+44, Screen_Width, OKLineHeight)];
            line.backgroundColor = Color_Line;
            
            if (i==1||i==2) {
                
            } else {
                if (i==3) {
                    line.y = _bgView.height-44.5;
                }
                [_bgView addSubview:line];
            }
        }
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(_bgView.width/2.f-0.25, _bgView.height-44, 0.5, 44)];
        line1.backgroundColor = Color_Line;
        [_bgView addSubview:line1];
        
    }else
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,44, Screen_Width, OKLineHeight)];
        line.backgroundColor = Color_Line;
        [_bgView addSubview:line];
        
    }
    [self.bgWindow addSubview:self];
    
    _okDatePicker = [[UIDatePicker alloc] init];
    _okDatePicker.datePickerMode = pickMode;
    _okDatePicker.y = 44.5;
    _okDatePicker.centerX = _bgView.centerX;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    _okDatePicker.locale = locale;
    _okDatePicker.maximumDate = self.isSingleSelect?[self getFutureTimeWithYears:10]:[NSDate date];
    _okDatePicker.minimumDate = self.isSingleSelect?[NSDate date]:dateFromString(@"2010-01-01 08:00:00");
    _okDatePicker.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    CGFloat varHeight = self.isSingleSelect?0:44;
    _okDatePicker.frame = CGRectMake(0, 44.5, Screen_Width, _bgView.height-44.5-varHeight);
    if (OKChooseTimeModel == _okDatePicker.datePickerMode) [_okDatePicker setLocale:[NSLocale systemLocale]];
    [_bgView addSubview:_okDatePicker];
    
    [_okDatePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self btnClicked:(UIButton *)[_bgView viewWithTag:8888]];
    
    // 初始化统一时间格式 yyyy-MM-dd HH:mm:ss
    if (startDate.length)
    {
        if (UIDatePickerModeTime == pickMode) {
            _startDate = [NSString stringWithFormat:@"2015-06-06 %@:00",startDate];
        }else{
            _startDate = [NSString stringWithFormat:@"%@ 00:00:00",startDate];
        }
        [_okDatePicker setDate:dateFromString(_startDate) animated:YES];
        [self setBtn:StartBtn withTitle:[@"开始时间\n" stringByAppendingString:startDate] AdSelect:YES];
    }else{
        if (self.isSingleSelect) _startDate = dateString([NSDate date]);
    }
    
    if (endDate.length)
    {
        if (UIDatePickerModeTime == pickMode) {
            _endDate = [NSString stringWithFormat:@"2015-06-06 %@:00",endDate];
        }else{
            _endDate = [NSString stringWithFormat:@"%@ 00:00:00",endDate];;
        }
        [self setBtn:EndBtn withTitle:[@"结束时间\n" stringByAppendingString:endDate] AdSelect:NO];
    }
}

#pragma mark - Business Method
- (void)pickerValueChanged:(UIDatePicker *)sender
{
    NSDate *compareDate = NULL;
    if (StartBtn && StartBtn.isSelected)
    {
        compareDate = dateFromString(_endDate);
        if (compareDate)
        {
            if ([compareDate compare:dateFromString(dateString(sender.date))]==NSOrderedAscending || ([dateFromString(dateString(sender.date)) compare:compareDate] ==NSOrderedSame && self.isSame))
            {
                showAlertToast(@"结束时间需大于开始时间");
                EnsureBtn.enabled = NO;
                _startDate = nil;
                
                [self setBtn:StartBtn withTitle:@"开始时间" AdSelect:YES];
                return;
            }
        }
        EnsureBtn.enabled = compareDate?YES:NO;;
        _startDate = dateString(sender.date);
        [self setBtn:StartBtn withTitle:[@"开始时间\n" stringByAppendingString:[self showDateWithArr:[_startDate componentsSeparatedByString:@" "]]]AdSelect:YES];
        
    }
    else if (EndBtn && EndBtn.isSelected)
    {
        compareDate = dateFromString(_startDate);
        if (compareDate)
        {
            if ([dateFromString(dateString(sender.date)) compare:compareDate]==NSOrderedAscending || ([dateFromString(dateString(sender.date)) compare:compareDate] ==NSOrderedSame && self.isSame))
            {
                showAlertToast(@"结束时间需大于开始时间");
                EnsureBtn.enabled = NO;
                _endDate = nil;
                
                [self setBtn:EndBtn withTitle:@"结束时间" AdSelect:YES];
                return;
            }
        }
        EnsureBtn.enabled = compareDate?YES:NO;
        _endDate = dateString(sender.date);
        [self setBtn:EndBtn withTitle:[@"结束时间\n" stringByAppendingString:[self showDateWithArr:[_endDate componentsSeparatedByString:@" "]]]AdSelect:YES];
    }
    //单选
    else
    {
        EnsureBtn.enabled = YES;
        _startDate = dateString(sender.date);
    }
}

- (void)btnClicked:(UIButton *)btn
{
    if (nil == btn) return;
    
    UIButton *btn1 = (UIButton *)[_bgView viewWithTag:8888];
    UIButton *btn2 = (UIButton *)[_bgView viewWithTag:8889];
    
    NSDate *currDate = nil;
    if (self.mode==UIDatePickerModeDate) {
        EnsureBtn.enabled = _startDate.length && _endDate.length;
    }
    
    if (btn.tag>=8888)
    {
        //开始时间Btn
        if (btn.tag == 8888)
        {
            btn1.selected = !btn1.selected;
            if (btn1.isSelected)
            {
                NSString *startDateStr = btn1.titleLabel.attributedText.string;
                if ([startDateStr isEqualToString:@"开始时间"])
                {
                    currDate = OKChooseCurrentDate;
                }else
                {
                    currDate = [self showDateWithString:startDateStr];
                }
                
                [_okDatePicker setDate:currDate animated:YES];
                
                btn1.userInteractionEnabled = NO;
                btn2.selected = NO;
                btn2.userInteractionEnabled = YES;
                // 颜色切换
                [self setBtn:btn1 withTitle:btn1.titleLabel.text AdSelect:YES];
                [self setBtn:btn2 withTitle:btn2.titleLabel.text AdSelect:NO];
                
            }
        }
        //结束时间Btn
        if (btn.tag == 8889)
        {
            btn2.selected = !btn2.selected;
            if (btn2.isSelected)
            {
                NSString *endDateStr = btn2.titleLabel.attributedText.string;
                if ([endDateStr isEqualToString:@"结束时间"])
                {
                    currDate = OKChooseCurrentDate;
                }else
                {
                    currDate = [self showDateWithString:endDateStr];
                }
                
                [_okDatePicker setDate:currDate animated:YES];
                
                btn1.selected = NO;
                btn2.userInteractionEnabled = NO;
                btn1.userInteractionEnabled = YES;
                
                // 颜色切换
                [self setBtn:btn2 withTitle:btn2.titleLabel.text AdSelect:YES];
                [self setBtn:btn1 withTitle:btn1.titleLabel.text AdSelect:NO];
            }
        }
        return;
    }
    [self dismiss:nil];
    
    if (self.block || self.singleBlock)
    {
        self.isSingleSelect?self.singleBlock([self showDateWithArr:[_startDate componentsSeparatedByString:@" "]],btn.tag==7778):self.block([self showDateWithArr:[_startDate componentsSeparatedByString:@" "]],[self showDateWithArr:[_endDate componentsSeparatedByString:@" "]],btn.tag==7778);
    }
}

- (void)setBtn:(UIButton *)btn withTitle:(NSString *)text AdSelect:(BOOL)flag
{
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *titleColor = flag?Color_Main:UIColorFromHex(0xa4a4a4);
    if (text.length==4) {
        [mStr setAttributes:@{NSFontAttributeName:FONTSYSTEM(14),NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, 4)];
        [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    }
    else if (text.length>4) {
        [mStr setAttributes:@{NSFontAttributeName:FONTSYSTEM(14),NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, 4)];
        [mStr setAttributes:@{NSFontAttributeName:FONTSYSTEM(12),NSForegroundColorAttributeName:UIColorFromHex(0xa4a4a4)} range:NSMakeRange(5, text.length-5)];
        [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    }
}

- (void)show
{
    WEAKSELF
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         weakSelf.alpha = 1;
                         CGRect frame = weakSelf.bgView.frame;
                         frame.origin.y -= DEFAULT_H;
                         [weakSelf.bgView setFrame:frame];
                     } completion:nil];
}
- (void)dismiss:(UIGestureRecognizer *)gesture {
    
    if (gesture)
        if (CGRectContainsPoint(_bgView.frame, self.touchPoint)) return;
    WEAKSELF
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         weakSelf.alpha = 0.0;
         CGRect frame = weakSelf.bgView.frame;
         frame.origin.y += DEFAULT_H;
         [weakSelf.bgView setFrame:frame];

     } completion:^(BOOL finished) {
                         [weakSelf removeFromSuperview];
                     }];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    self.touchPoint = point;
    return  [super hitTest:point withEvent:event];
}

#pragma mark - 时间字符串处理
/** 显示时间样式字符串*/
-(NSString *)showDateWithArr:(NSArray *)componentsArr
{
    if (!componentsArr.count) return nil;
    NSString *dateTitle = NULL;
    
    if (OKChooseTimeModel == self.okDatePicker.datePickerMode)
    {
        dateTitle = componentsArr.lastObject;
        // 截取秒位
        if (3 == [dateTitle componentsSeparatedByString:@":"].count)
            dateTitle = [dateTitle substringWithRange:NSMakeRange(0, dateTitle.length -3)];
    }else
    {
        dateTitle = componentsArr.firstObject;
    }
    return dateTitle;
}
/** 时间字符串转换时间戳*/
-(NSDate *)showDateWithString:(NSString *)dateString
{
    if ([dateString rangeOfString:@"时间"].location != NSNotFound && dateString.length>=5) {
        dateString = [dateString substringFromIndex:5];
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    if (OKChooseTimeModel == self.okDatePicker.datePickerMode)
    {
        dateString = [NSString stringWithFormat:@"%@ %@:00",dateStringWithoutHMS(OKChooseCurrentDate),dateString];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return [dateFormatter dateFromString:dateString];
}

/** 获取下一天时间---*/
-(NSDate *)getNextDayTimeWithDate:(NSDate *)currDaty
{
    if (NULL == currDaty) return nil;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
    [components setDay:+1];
    return [cal dateByAddingComponents:components toDate:currDaty options:0];
}
/** 获取未来最大年份--*/
-(NSDate *)getFutureTimeWithYears:(NSInteger)year
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
    [components setYear:+year];
    return [cal dateByAddingComponents:components toDate:[NSDate date] options:0];
    
}
/** 获取当前时间戳--*/
-(NSDate *)getCurrentDate
{
    NSString *currDate = dateString([NSDate date]);
    currDate = [NSString stringWithFormat:@"%@ 00:00:00",[currDate componentsSeparatedByString:@" "].firstObject];
    return dateFromString(currDate);
}
/** 获取当前时间字符串--*/
-(NSString *)getCurrentDateString
{
    NSString *currDate = dateString([NSDate date]);
    currDate = [NSString stringWithFormat:@"%@ 00:00:00",[currDate componentsSeparatedByString:@" "].firstObject];
    return currDate;
}

@end
