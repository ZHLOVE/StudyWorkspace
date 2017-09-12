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
    //测试
    [self exitApplication];
}

/**
 * 调用代码使APP进入后台，达到点击Home键的效果。（私有API）
 */
- (void)suspendApp
{
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
}

- (void)exitApplication {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

/**
 * 设置UI圆角
 */
- (void)setBezierPathCorner
{
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 100, 80, 80)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = maskPath.CGPath;
    view2.layer.mask = maskLayer;
}

/**
 显示\隐藏展示图
 */
-(IBAction)changeAppAction:(id)sender
{
    self.scrollView.hidden = !self.scrollView.hidden;
}

@end
