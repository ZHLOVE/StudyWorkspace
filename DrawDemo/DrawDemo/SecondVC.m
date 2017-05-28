//
//  SecondVC.m
//  DrawDemo
//
//  Created by mao wangxin on 2017/5/27.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "SecondVC.h"
#import "LukeView.h"

@interface SecondVC ()
@property (weak, nonatomic) IBOutlet LukeView *contentView;
@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
}

@end
