//
//  LoginViewModel.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/7.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    if (self = [super init]) {
        //初始化信号
        [self setUpSignal];
    }
    return self;
}

/**
 * 初始化信号
 */
- (void)setUpSignal
{
    _loginBtnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, passWord)] reduce:^id (NSString *userName, NSString *passWord){
        return @(userName.length && passWord.length);
    }];
    
    
    @weakify(self)
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        
        //发送网络请求
        self.statusTip = @"发送网络请求！";
        NSLog(@"%@",self.statusTip);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            self.statusTip = @"请求到的网络数据";
            NSLog(@"%@",self.statusTip);
            
            //发送数据
            [subscriber sendNext:self.statusTip];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //获取命令中的信号源
    [_loginCommand .executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"获取命令中的信号源==%@",x);
    }];
    
    //skip:跳过1次执行
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        
        if ([x boolValue] == YES) {
            self.statusTip = @"正在执行。。。";
            NSLog(@"%@",self.statusTip);
            
        } else {
            self.statusTip = @"执行完毕！！！";
            NSLog(@"%@",self.statusTip);
        }
    }];
}

@end
