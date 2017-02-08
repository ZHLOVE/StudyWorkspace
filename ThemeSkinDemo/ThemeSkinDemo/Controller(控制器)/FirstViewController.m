//
//  FirstViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "FirstViewController.h"
#import "OKTabBarInfoModel.h"
#import "OKAppTabBarVC.h"
#import "UITabBar+BadgeView.h"
#import "OKFileManager.h"

#define MaxOffsetX      (self.view.width-49)

@interface FirstViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *pan;//UIScreenEdgePanGestureRecognizer
@property (nonatomic, assign) CGFloat startTabBarY;
//左侧蒙版
@property (nonatomic, strong) UIView *leftMaskView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加边缘侧滑手势控制器
    [self addScreenPan];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.startTabBarY = self.parentViewController.tabBarController.tabBar.y;
    
    [self leftMaskView];
}

- (UIView *)leftMaskView
{
    if (!_leftMaskView) {
        _leftMaskView = [[UIView alloc] init];
        _leftMaskView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        _leftMaskView.backgroundColor = [UIColor blackColor];
        _leftMaskView.alpha = 0.5;
        [self.parentViewController.view insertSubview:_leftMaskView atIndex:1];
    }
    return _leftMaskView;
}

/**
 * 是否打开左侧视图
 */
- (void)converLeftViewAction:(UIButton *)button
{
    [self showLeftView:(self.view.x != MaxOffsetX)];
}

/**
 * 是否关闭左侧视图
 */
- (void)showLeftView:(BOOL)open
{
    [UIView animateWithDuration:0.3 animations:^{
        if (open) { //打开侧滑
            self.leftMaskView.alpha = 0.0;
            self.view.x = MaxOffsetX;
            self.view.height = Screen_Height;
            self.parentViewController.tabBarController.tabBar.y =  self.startTabBarY + 49;
            self.parentViewController.tabBarController.tabBar.alpha = 0.0;
            
        } else { //关闭侧滑
            self.view.x = 0;
            self.view.height = Screen_Height - 49;
            self.parentViewController.tabBarController.tabBar.y =  self.startTabBarY + 0;
            self.leftMaskView.alpha = 0.5;
            self.parentViewController.tabBarController.tabBar.alpha = 1.0;
        }
    }];
}

#pragma Mark - 初始化UI

/**
 * 添加边缘侧滑手势控制器
 */
- (void)addScreenPan
{
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainSlideHandlePan:)];
    //self.pan.edges = UIRectEdgeLeft;
    self.pan.delegate = self;
    [self.pan setCancelsTouchesInView:YES];
    [self.view addGestureRecognizer:self.pan];
    
    //添加侧滑投影效果
    [self.view.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.view.layer setShadowRadius:5];
    [self.view.layer setShadowOpacity:1];
    [self.view.layer setShadowColor:[UIColor colorWithWhite:0 alpha:0.48].CGColor];
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, Screen_Height)].CGPath;
}

#pragma mark - 滑动手势

//滑动手势
- (void)mainSlideHandlePan:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self.parentViewController.view];
    
    //屏幕宽度一半的百分比
    CGFloat percent = point.x/(self.view.width/2);
    CGFloat offsetY = self.parentViewController.tabBarController.tabBar.height *percent;
    
    self.view.x = MIN((MAX(point.x, 0)), MaxOffsetX);
    self.parentViewController.tabBarController.tabBar.y =  self.startTabBarY + MAX(offsetY, 0);
    
    self.leftMaskView.alpha = 0.5 * (1-percent);
    self.parentViewController.tabBarController.tabBar.alpha = 1-percent;
    self.view.height = Screen_Height-49+MAX(offsetY, 0);
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self showLeftView:(point.x > self.view.width/2)];
        }];
    }
}

/**
 * 监听重复点击tabBar按钮事件
 */
- (void)repeatTouchTabBarToViewController:(UIViewController *)touchVC
{
    NSLog(@"touchVC===%@===%@===%@",touchVC,self,self.tabBarController);
    //设置小红点
    [self.tabBarController.tabBar showBadgeOnItemIndex:0];
}

/**
 * 默认主题
 */
- (IBAction)jumpAction:(UIButton *)sender
{
    NSString *tabBarPath = [OKFileManager getTabBarDirectory];
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:tabBarPath error:nil];
    NSLog(@"删除沙盒图标状态===%zd",success);
    
    OKAppTabBarVC *tabbarVC = (OKAppTabBarVC *)self.tabBarController;
    [tabbarVC setDefaultTabBarImages];
}

/**
 * 增加tabbar
 */
- (IBAction)addTabbarAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    OKAppTabBarVC *tabbarContr = (OKAppTabBarVC *)self.tabBarController;
    
    NSMutableArray *newItemArr = [NSMutableArray arrayWithArray:tabbarContr.viewControllers];
    
    if (!sender.selected) {
        [newItemArr removeObjectAtIndex:(newItemArr.count-1)];
        tabbarContr.viewControllers = newItemArr;
        
        //刷新添加的小红点
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tabBarController.tabBar refreshTabBarRoundView];
        });
        return;
    }
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.title = @"UIViewController";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    vc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_property_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_property_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.title = @"双十一";
    if (self.tabBarItem.imageInsets.bottom == 20) {
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -10);
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-20, 0, 20, 0);
    }
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x282828), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0xfe9b00), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [newItemArr addObject:nav];
    tabbarContr.viewControllers = newItemArr;
    
    //刷新添加的小红点
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tabBarController.tabBar refreshTabBarRoundView];
    });
}

/**
 * 换肤
 */
- (IBAction)reduceTabbarItem:(UIButton *)button
{
    button.selected = !button.selected;
    [self requestIconData:nil];
}

/**
 请求icon数据
 */
- (void)requestIconData:(NSArray *)iconUrlArr
{
    iconUrlArr = [NSArray arrayWithObjects:
                  @"http://www.iconpng.com/download/png/100864",
                  @"http://www.iconpng.com/download/png/70161",
                  @"http://www.iconpng.com/download/ico/99504",
                  @"http://www.iconpng.com/download/ico/99504",nil];
    
    dispatch_group_t group = dispatch_group_create();
    
    NSMutableArray *downloadIconArr = [NSMutableArray array];
    
    for (NSString *iconUrlStr in iconUrlArr) {
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrlStr]]];
            NSLog(@"下载的图片===%@",image);
            [downloadIconArr addObject:image];
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSMutableArray *tabBarInfoArr = [NSMutableArray array];
        
        NSArray *defaultNormolImageArr = @[@"tabbar_home_n",@"tabbar_property_n",@"tabbar_my_n"];
        for (int i=0; i<downloadIconArr.count; i++) {
            UIImage *iconImage = downloadIconArr[i];
            if (![iconImage isKindOfClass:[UIImage class]]) continue;
            
            //设置尺寸
            UIImage *convertImage = [UIImage scaleToSize:iconImage size:CGSizeMake(31*2, 31*2)];
            NSString *saveImagePath = [NSString stringWithFormat:@"%@/%@@2x.png",[OKFileManager getTabBarDirectory],defaultNormolImageArr[i]];
            [UIImagePNGRepresentation(convertImage) writeToFile:saveImagePath atomically:NO];
            
            NSLog(@"下载图片是否保存成功===%@",saveImagePath);
            
            OKTabBarInfoModel *infoModel = [[OKTabBarInfoModel alloc] init];
            infoModel.tabBarItemTitle = [NSString stringWithFormat:@"测试%zd",i];
            infoModel.tabBarNormolImage = ImageNamed(saveImagePath)?:convertImage;
            infoModel.tabBarSelectedImage = ImageNamed(saveImagePath)?:convertImage;
            infoModel.tabBarNormolTitleColor = UIColorFromHex(0x282828);
            infoModel.tabBarSelectedTitleColor = UIColorFromHex(0xfe9b00);
            infoModel.tabBarTitleOffset = -10;
            infoModel.tabBarImageOffset = -20;
            
            [tabBarInfoArr addObject:infoModel];
        }
        NSLog(@"下载完成===%@",tabBarInfoArr);
        [(OKAppTabBarVC *)self.tabBarController changeTabBarThemeImages:tabBarInfoArr];
    });
}

@end
