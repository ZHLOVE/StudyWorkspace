//
//  DrawPathView.m
//  DrawDemo
//
//  Created by Luke on 2017/6/4.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "DrawPathView.h"

@interface DrawPathView ()
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation DrawPathView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

/**
 *  图片Layer
 */
- (CALayer *)imageLayer
{
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
        _imageLayer.contents = (id)[UIImage imageNamed:@"icon_qq"].CGImage;
        _imageLayer.bounds =CGRectMake(0, 0, 50, 50);
        _imageLayer.position = CGPointMake(self.center.x, self.center.y);
        [self.layer addSublayer:_imageLayer];
    }
    return _imageLayer;
}

/**
 *  绘制的路径
 */
- (UIBezierPath *)bezierPath
{
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
        _bezierPath.lineWidth = 3;
        _bezierPath.lineJoinStyle = kCGLineJoinRound;
        _bezierPath.lineCapStyle = kCGLineCapRound;
    }
    return _bezierPath;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touche = [touches anyObject];
    
    CGPoint startPoint = [touche locationInView:self];
    
    //得到一个绘制起始点
    [self.bezierPath moveToPoint:startPoint];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touche = [touches anyObject];
    
    CGPoint movePoint = [touche locationInView:self];

    //绘制路径
    [self.bezierPath addLineToPoint:movePoint];
    
    [self setNeedsDisplay];
}

/**
 *  轨迹运动
 */
- (void)moveLayerFromPath
{
//    [self afreshDrawPath];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    keyAnimation.path = self.bezierPath.CGPath;
    keyAnimation.duration = 5;
    keyAnimation.repeatCount = MAXFLOAT;
    [self.imageLayer addAnimation:keyAnimation forKey:@"positionAnimation"];
}


/**
 *  开始绘制
 */
- (void)startDrawPath
{
    [self bezierPath];
//    self.clearsContextBeforeDrawing = 
}


/**
 *  重新绘制
 */
- (void)afreshDrawPath
{
    self.bezierPath = nil;
    [self.imageLayer removeAnimationForKey:@"positionAnimation"];
    [self.imageLayer removeFromSuperlayer];
    self.imageLayer = nil;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.bezierPath stroke];
}


/**
 *  随机色
 */
- (UIColor *)arcColor
{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
