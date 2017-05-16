//
//  ThreeViewController.m
//  XibDemo
//
//  Created by mao wangxin on 2017/2/28.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"self.scrollView==%@\nself.view==%@",self.scrollView,self.view);
    
//    CGRect rect = self.scrollView.frame;
//    rect.origin.y = 0;
//    rect.size.height = self.view.bounds.size.height;
//    self.scrollView.frame = rect;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
