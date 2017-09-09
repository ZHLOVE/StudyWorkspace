//
//  ViewController.m
//  MutableTargetDemo
//
//  Created by mao wangxin on 2017/9/8.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.textLabel.text = RequestURL;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CCLog(@"%s",__func__);
}


@end
