//
//  OKAppGuideView.m
//  CommonFrameWork
//
//  Created by Luke on 2017/8/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "OKAppGuideView.h"
#import "UIView+OKExtension.h"
#import "OKPubilcKeyDefiner.h"
#import "OKFrameDefiner.h"
#import "OKColorDefiner.h"
#import "OKCFunction.h"

//view背景
#define Color_BackGround           UIColorFromHex(0xf5f5f5)
//纯白色
#define WhiteColor                 [UIColor whiteColor]

@interface OKAppGuideView ()<UIScrollViewDelegate>

/** 跳过 */
@property (nonatomic, strong) UIButton *jumpBtn;
/** 引导页 */
@property (nonatomic, strong) UIScrollView  *imgScrollView;
/** 引导页数 */
@property (nonatomic, strong) NSArray       *imageArr;
@end

@implementation OKAppGuideView

/**
 *  展示App新版本引导图
 */
+(void)showAppGuideView
{
    OKAppGuideView *appView = [[OKAppGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].delegate.window addSubview:appView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = Color_BackGround;
        self.jumpBtn.hidden = NO;
    }
    return self;
}

/**
 *  跳过按钮
 */
- (UIButton *)jumpBtn
{
    if (!_jumpBtn) {
        _jumpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 0, 0)];
        [_jumpBtn setTitle:@"跳过>" forState:0];
        _jumpBtn.titleLabel.font = FONTSYSTEM(15);
        [_jumpBtn setTitleColor:WhiteColor forState:0];
        [_jumpBtn setTitleColor:[WhiteColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [_jumpBtn addTarget:self action:@selector(jumpBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_jumpBtn sizeToFit];
        _jumpBtn.x = Screen_Width - (_jumpBtn.width+20);
        [self addSubview:_jumpBtn];
    }
    return _jumpBtn;
}

/**
 *  引导页数图片
 */
- (NSArray *)imageArr
{
    if (!_imageArr) {
        if (IS_IPHONE4) {
            _imageArr = [[NSArray alloc] initWithObjects:
                         ImageNamed(@"guide1_iPhone4.jpg"),ImageNamed(@"guide2_iPhone4.jpg"),ImageNamed(@"guide3_iPhone4.jpg"),nil];
        } else if (IS_IPHONE5) {
            _imageArr = [[NSArray alloc] initWithObjects:
                         ImageNamed(@"guide1_iPhone5.jpg"),ImageNamed(@"guide2_iPhone5.jpg"),ImageNamed(@"guide3_iPhone5.jpg"),nil];
        } else if (IS_IPhone6) {
            _imageArr = [[NSArray alloc] initWithObjects:
                         ImageNamed(@"guide1_iPhone6.jpg"),ImageNamed(@"guide2_iPhone6.jpg"),ImageNamed(@"guide3_iPhone6.jpg"),nil];
        } else if (IS_IPhone6plus) {
            _imageArr = [[NSArray alloc] initWithObjects:
                         ImageNamed(@"guide1_iPhone6p.jpg"),ImageNamed(@"guide2_iPhone6p.jpg"),ImageNamed(@"guide3_iPhone6p.jpg"),nil];
        }
    }
    return _imageArr;
}

- (void)initUI
{
    self.imgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.imgScrollView.delegate = self;
    self.imgScrollView.showsHorizontalScrollIndicator = NO;
    self.imgScrollView.showsVerticalScrollIndicator = NO;
    self.imgScrollView.bounces = NO;
    self.imgScrollView.pagingEnabled = YES;
    self.imgScrollView.contentSize = CGSizeMake(self.imageArr.count * Screen_Width , Screen_Height);
    [self addSubview:self.imgScrollView];
    
    CGFloat buttonMaxY = 0;
    
    for (int i = 0; i < self.imageArr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width * i, 0, Screen_Width, Screen_Height)];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.userInteractionEnabled = YES;
        imageView.image = self.imageArr[i];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imgScrollView addSubview:imageView];
        
        if (i == self.imageArr.count-1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitle:@"立即体验" forState:0];
            [button setTitleColor:WhiteColor forState:0];
            [button setTitleColor:[WhiteColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
            button.frame = CGRectMake(0, 0, 240/2, 72/2);
            button.layer.cornerRadius = button.size.height/2;
            button.layer.borderWidth = 1;
            button.layer.borderColor = WhiteColor.CGColor;
            button.centerX = self.centerX;
            button.y = Screen_Height-(button.size.height+64);
            [button addTarget:self action:@selector(startLaunching) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            
            buttonMaxY = CGRectGetMaxY(button.frame);
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startLaunching)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/Screen_Width;
    
    if (page < (self.imageArr.count-1)) {
        self.jumpBtn.hidden = NO;
    } else {
        self.jumpBtn.hidden = YES;
    }
}

/**
 *  开始启动
 */
- (void)startLaunching
{
    SaveUserDefault(currentVersion(), currentVersion());
    
    [UIView animateWithDuration:1 animations:^{
        self.transform = CGAffineTransformMakeScale(4, 4);
        self.alpha = 0;
        self.jumpBtn.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.jumpBtn removeFromSuperview];
        [self removeFromSuperview];
    }];
}

/**
 *  跳过
 */
- (void)jumpBtnAction
{
    SaveUserDefault(currentVersion(), currentVersion());
    
    [self.jumpBtn removeFromSuperview];
    self.jumpBtn = nil;
    [self removeFromSuperview];
}

@end
