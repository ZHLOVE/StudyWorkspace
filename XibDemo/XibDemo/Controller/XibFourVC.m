//
//  XibFourVC.m
//  XibDemo
//
//  Created by mao wangxin on 2017/6/2.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "XibFourVC.h"

@interface XibFourVC ()

@end

@implementation XibFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnAction:(UIButton *)sender
{
    NSString *str = @"哈哈";
    
    NSLog(@"btnAction===%@",str);
    
    // 根据指定线的ID跳转到目标Vc
    [self performSegueWithIdentifier:@"SendValue" sender:str];
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender
{
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSegue===%@===%@",segue,sender);
    
    // segue.identifier：获取连线的ID
    if ([segue.identifier isEqualToString:@"SendValue"]) {
        // segue.destinationViewController：获取连线时所指的界面（VC）
        
        UIViewController *receive = segue.destinationViewController;
        [receive setValuesForKeysWithDictionary:@{@"name":@"Luke",@"age":@"100"}];
        
//        receive.name = @"Luke";
//        receive.age = 110;
        // 这里不需要指定跳转了，因为在按扭的事件里已经有跳转的代码
        // [self.navigationController pushViewController:receive animated:YES];
    }
}

@end
