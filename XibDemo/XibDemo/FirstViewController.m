//
//  FirstViewController.m
//  XibDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *bgVidew;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)touchBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSLog(@"textLabel11111===%@====%@",self.bgVidew,self.textLabel);
    
    if (!sender.selected) {
        self.textLabel.text = @"具有优先级1000（UILayoutPriorityRequired）的约束为强制约束（Required Constraint），也就是必须要满足的约束；优先级小于1000的约束为可选约束（Optional Constraint）。默认创建的是强制约束。\n在使用自动布局后，某个视图的具体位置和尺寸可能由多个约束来共同决定。这些约束会按照优先级从高到低的顺序来对视图进行布局，也就是视图会优先满足优先级高的约束，然后满足优先级低的约束。\n对于上面的例子，我们曾经创建了两个相互冲突的约束";
    } else {
        self.textLabel.text = @"具有优先级1000（UILayoutPriorityRequired）的约束为强制约束（Required Constraint），也就是必须要满足的约束；优先级小于1000的约束为可选约束（Optional Constraint）。默认创建的是强制约束。\n在使用自动布局后，某个视图的具体位置和尺寸可能由多个约束来共同决定。这些约束会按照优先级从高到低的顺序来对视图进行布局，";
    }
    
    NSLog(@"textLabel2222===%@====%@",self.bgVidew,self.textLabel);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews===%@====%@",self.bgVidew,self.textLabel);
}

@end
