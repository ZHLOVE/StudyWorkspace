//
//  AppTabBarVC1.m
//  SlideApp
//
//  Created by mao wangxin on 2017/2/9.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "AppTabBarVC1.h"

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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    // self.view.tintColor = [UIColor redColor];
    
    NSLog(@"\n====%@\n====%@",self.view.window.tintColor,self.view.tintColor);
    
    self.view.tintColor = [UIColor redColor];
    
    self.view.window.tintColor = [UIColor redColor];
}

@end
