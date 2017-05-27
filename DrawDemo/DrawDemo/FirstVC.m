//
//  FirstVC.m
//  DrawDemo
//
//  Created by mao wangxin on 2017/5/27.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, assign) BOOL finish;
@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self viewAnimation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIView setAnimationsEnabled:NO];
    
    self.finish = YES;
}

/**
 * 初始化imageView3
 */
- (UIImageView *)imageView3
{
    if(!_imageView3){
        _imageView3 = [[UIImageView alloc] init];
        _imageView3.image = [UIImage imageNamed:@"2.jpg"];
        _imageView3.frame = CGRectMake(0, self.view.center.y, 150, 150);
        _imageView3.layer.cornerRadius = 150/2;
        _imageView3.layer.masksToBounds = YES;
        [self.view addSubview:_imageView3];
    }
    return _imageView3;
}

/**
 * UIView动画: 添加旋和平移转动画
 */
- (void)viewAnimation
{
    __block CGRect rect = self.imageView3.frame;
    
    [UIView animateWithDuration:5 animations:^{
        //旋转
        self.imageView3.transform = CGAffineTransformMakeRotation(M_PI);
        
        //平移
        //self.imageView3.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width-self.imageView3.bounds.size.width, 0);
        rect.origin.x = self.view.bounds.size.width-self.imageView3.bounds.size.width;
        self.imageView3.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:5 animations:^{
            //self.imageView3.transform = CGAffineTransformMakeTranslation(0, 0);
            self.imageView3.transform = CGAffineTransformMakeRotation(-M_PI * 2);
            rect.origin.x = 0;
            self.imageView3.frame = rect;
            
        } completion:^(BOOL finished) {
            if (!self.finish) {
                [self viewAnimation];
            }
        }];
    }];
}

- (void)dealloc
{
    NSLog(@"FirstVC dealloc");
}

@end
