//
//  OKChooseDateView.h
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    OKYMDStyle,                        //Y:M:D样式
    OKHMStyle,                         //H:M样式
} OKChooseDateViewStyle;

@interface OKChooseDateView : UIView

@property (nonatomic, strong) UIDatePicker *GJDatePicker;
/**开始结束时间是否允许相等*/
@property(nonatomic,assign)BOOL isSame;

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
                    callBackHand:(void (^)(NSString *chooseStartDate, NSString *chooseEndDate, BOOL flag))block;

+(instancetype)showWithSingleSelectionBlock:(void (^)(NSString *date, BOOL flag))block;


@end
