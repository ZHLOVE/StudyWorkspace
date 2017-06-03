//
//  DrawCircleVC.m
//  DrawDemo
//
//  Created by Luke on 2017/6/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "DrawCircleVC.h"

@interface DrawCircleVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) CALayer *circleLayer;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@end

@implementation DrawCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)drawCircleAction:(UIButton *)sender
{
    [self.circleLayer removeAllAnimations];
    [self.replicatorLayer removeFromSuperlayer];
    
    if (sender.selected) {
        sender.selected = NO;
        [sender setTitle:@"画圈" forState:0];
    } else {
        sender.selected = YES;
        [sender setTitle:@"停止画圈" forState:0];
        //画圈
        [self drawCircle];
    }
}

/**
 *  画圈
 */
- (void)drawCircle
{
    NSInteger duplicateCount = 30;
    CGFloat smallCircleSize = 10;
    CGFloat starttX = self.contentView.bounds.size.width/2 - smallCircleSize/2;
    
    CALayer *circleLayer = [CALayer layer];
    circleLayer.backgroundColor = [UIColor redColor].CGColor;
    circleLayer.bounds = CGRectMake(0, 0, 0, 0);
    circleLayer.position = CGPointMake(starttX, smallCircleSize);
    circleLayer.cornerRadius = smallCircleSize/2;
    circleLayer.masksToBounds = YES;
    self.circleLayer = circleLayer;
    
    CGFloat duration = 2;
    CGRect fromRect = CGRectMake(0, 0, 0, 0);
    CGRect toRect = CGRectMake(0, 0, smallCircleSize, smallCircleSize);
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"bounds";
    anima.fromValue = [NSValue valueWithCGRect:fromRect];
    anima.toValue = [NSValue valueWithCGRect:toRect];
    anima.duration = duration;
    anima.repeatCount = MAXFLOAT;
    [circleLayer addAnimation:anima forKey:@"circleAnima"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.contentView.bounds;
    [replicatorLayer addSublayer:circleLayer];
    
    CGFloat angle = M_PI * 2 / duplicateCount;
    
    replicatorLayer.instanceCount = duplicateCount;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceDelay = duration / duplicateCount;
    
    [self.contentView.layer addSublayer:replicatorLayer];
    self.replicatorLayer = replicatorLayer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
