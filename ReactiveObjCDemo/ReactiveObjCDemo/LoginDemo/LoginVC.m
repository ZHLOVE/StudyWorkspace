//
//  LoginVC.m
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/6/7.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "LoginVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginViewModel.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UILabel *statusTipLab;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) LoginViewModel *loginVM;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RAC(self.loginVM, userName) = self.accountTextField.rac_textSignal;
    
    RAC(self.loginVM, passWord) = self.pwdTextField.rac_textSignal;
    
    RAC(self.loginBtn, enabled) = self.loginVM.loginBtnEnableSignal;
    
    @weakify(self)
    RAC(self.statusTipLab,hidden) = [RACSignal combineLatest:@[RACObserve(self.loginVM, statusTip)] reduce:^id (NSString *statusTip){
        @strongify(self)
        self.statusTipLab.text = statusTip;
        return @(!statusTip.length);
    }];
    
    //监听按钮点击事件
    [[_loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        //取消键盘
        [self.view endEditing:YES];
        
        NSLog(@"处理登录事件");
        [self.loginVM.loginCommand execute:nil];
    }];
}

/**
 * 初始化
 */
- (LoginViewModel *)loginVM
{
    if(!_loginVM){
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //取消键盘
    [self.view endEditing:YES];
    self.statusTipLab.hidden = YES;
}

@end
