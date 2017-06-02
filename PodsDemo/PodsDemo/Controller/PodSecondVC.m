//
//  SecondViewController.m
//  PodsDemo
//
//  Created by mao wangxin on 2017/1/5.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PodSecondVC.h"
#import "GJChartLineInfoView.h"

@interface PodSecondVC ()
@property (nonatomic, strong) GJChartLineInfoView *chartLineInfoView;
@end

@implementation PodSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self.chartLineInfoView.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.chartLineInfoView removeFromSuperview];
    self.chartLineInfoView = nil;
    
    //y轴刻度值
    NSArray *yAxleArr = @[@"1000",@"800",@"600",@"400",@"200",@"0"];
    
    //x轴刻度值
    NSMutableArray *xAxleArr = [NSMutableArray array];
    for (int i=0; i<15; i++) {
        [xAxleArr addObject:[NSString stringWithFormat:@"%zd",2000+i]];
    }
    
    //绘图点数据
    NSMutableArray *drawPointArr = [NSMutableArray array];
    for (int i=0; i<15; i++) {
        int x = 150 +  (arc4random() % 800);
        [drawPointArr addObject:[NSString stringWithFormat:@"%zd",x]];
    }
    
    CGRect rect = CGRectMake(0, 150, self.view.bounds.size.width, 20*7);
    GJChartLineInfoView *chartLineInfoView = [[GJChartLineInfoView alloc] initWithFrame:rect
                                                                              lineColor:[UIColor orangeColor]
                                                                      leftScaleValueArr:yAxleArr
                                                                    bottomScaleValueArr:xAxleArr
                                                                            lineDataArr:drawPointArr];
    [self.view addSubview:chartLineInfoView];
    self.chartLineInfoView = chartLineInfoView;
}

@end
