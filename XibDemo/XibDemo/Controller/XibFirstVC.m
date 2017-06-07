//
//  FirstViewController.m
//  XibDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "XibFirstVC.h"
#import <objc/runtime.h>
#import "LukeView.h"
#import "TempVC2.h"

static char const * const kMyName      = "myName";

@interface XibFirstVC ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *bgVidew;
@property (nonatomic, strong) DataModel *dataModel;
@end

@implementation XibFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 * 测试跳转
 */
- (IBAction)jumpBtnAction:(UIButton *)sender
{
    TempVC2 *vc = [[TempVC2 alloc] init];
    vc.title = @"哈哈😆";
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    NSLog(@"updateViewConstraints===%@====%@",self.bgVidew,self.textLabel);
}


/**
 * 初始化
 */
- (DataModel *)dataModel
{
    if(!_dataModel){
        _dataModel = [[DataModel alloc] init];
    }
    return _dataModel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *tempStr1 = objc_getAssociatedObject(self, kMyName);
    
    NSLog(@"tempStr1===%@",tempStr1);
}

@end
