//
//  ViewController.m
//  MutableTargetDemo
//
//  Created by mao wangxin on 2017/9/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textLabel.text = RequestURL;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CCLog(@"%s",__func__);
}

/**
 显示\隐藏展示图
 */
-(IBAction)changeAppAction:(id)sender {
    self.scrollView.hidden = !self.scrollView.hidden;
}

/**
 * 单元测试: 判断传入一个数大于10
 */
- (BOOL)judgeNumGreaterTen:(NSInteger)number
{
    if (number > 10) {
        return YES;
    } else {
        return NO;
    }
}



@end
