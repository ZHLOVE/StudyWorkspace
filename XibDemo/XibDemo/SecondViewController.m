//
//  SecondViewController.m
//  XibDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "SecondViewController.h"
#import "LukeView.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *sharkBtn;
@property (weak, nonatomic) IBOutlet UIView *origreView;
@property (strong, nonatomic) UILabel *customLabel;
@property (nonatomic, strong) LukeView *lukeView;;
@end

@implementation SecondViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"self.origreView==%@\nself.view==%@",self.origreView,self.view);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *customLabel = [[UILabel alloc] init];
    customLabel.backgroundColor = [UIColor greenColor];
    customLabel.text = @"UILabel+UILabel";
    [customLabel sizeToFit];
    customLabel.center = self.view.center;
    [self.view addSubview:customLabel];
    self.customLabel = customLabel;
    
}

- (LukeView *)lukeView
{
    if (!_lukeView) {
        _lukeView = [[[NSBundle mainBundle] loadNibNamed:@"LukeView" owner:nil options:nil] firstObject];
        _lukeView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_lukeView];
    }
    return _lukeView;
}

/**
 * 抖动
 */
- (IBAction)btnAction:(id)sender
{
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"LukeView" owner:nil options:nil];
    if (xibArray.count>1) {
        NSLog(@"xibArray===%@",xibArray);
        UIView *lukeView = xibArray[1];
        lukeView.center = self.view.center;
        lukeView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:lukeView];
    }
    
    self.customLabel.center = CGPointMake(self.view.center.x-20, self.view.center.y);
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.1
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        self.customLabel.center = CGPointMake(self.view.center.x, self.view.center.y);
    } completion:nil];
}

/**
 * 约束动画
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textLabel removeFromSuperview];
    [self lukeView];
    [UIView animateWithDuration:3
                          delay:0
         usingSpringWithDamping:0.1
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         
                     }];
}

@end
