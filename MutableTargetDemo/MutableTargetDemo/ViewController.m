//
//  ViewController.m
//  MutableTargetDemo
//
//  Created by mao wangxin on 2017/9/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
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
    //测试
    [self pushToWebVC];
}

/**
 *  更新App
 */
- (void)pushToWebVC
{
    WebViewController *webVC = [[WebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
}

/**
 显示\隐藏展示图
 */
-(IBAction)changeAppAction:(id)sender
{
    self.scrollView.hidden = !self.scrollView.hidden;
}


@end
