//
//  SecondViewController.m
//  iOS_MVPDemo
//
//  Created by mao wangxin on 2017/8/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "SecondViewController.h"
#import <OKAlertView.h>

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)loginBtnAction:(id)sender
{
    if (_userNameTextField.hasText && _pwdTextField.hasText) {
        OKAlertSingleBtnView(@"温馨提示", @"登录成功了", @"确定")
    } else {
        OKAlertSingleBtnView(@"温馨提示", @"登录失败了", @"好的")
    }
}

@end
