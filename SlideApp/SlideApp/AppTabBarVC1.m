//
//  AppTabBarVC1.m
//  SlideApp
//
//  Created by mao wangxin on 2017/2/9.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "AppTabBarVC1.h"
#import "AppDelegate.h"

@interface AppTabBarVC1 ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation AppTabBarVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"\n====%@\n====%@",self.view.window.tintColor,self.view.tintColor);
    
    self.view.window.tintColor = [UIColor redColor];
}


- (IBAction)btnAction:(UIButton *)sender
{
    self.view.window.tintColor = nil;
    self.view.tintColor = nil;
}

/**
 * 调用代码使APP进入后台，达到点击Home键的效果。（私有API）
 */
- (void)suspendApp
{
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
}

/**
 * 调用代码使APP进入后台，达到点击Home键的效果。（私有API）
 */
- (void)exitApplication {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    // self.view.tintColor = [UIColor redColor];
    
    NSLog(@"\n====%@\n====%@",self.view.window.tintColor,self.view.tintColor);
    
    self.view.tintColor = [UIColor redColor];
    
    self.view.window.tintColor = [UIColor redColor];
}

@end
