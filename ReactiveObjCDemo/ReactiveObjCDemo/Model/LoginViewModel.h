//
//  LoginViewModel.h
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/7.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWord;
@property (nonatomic, strong) NSString *statusTip;
/** 登录按钮可点击信号 */
@property (nonatomic, strong) RACSignal *loginBtnEnableSignal;
/** 登录命令 */
@property (nonatomic, strong) RACCommand *loginCommand;
@end
