//
//  FirstViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "FirstViewController.h"
#import "OKAppTabBarVC.h"
#import "UITabBar+BadgeView.h"
#import <OKHttpRequestTools.h>
#import <OKAlertController.h>
#import "OKTabBarInfoModel.h"
#import <UIImage+OKExtension.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
 * 增加tabbar
 */
- (IBAction)addTabbarAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    OKAppTabBarVC * tabbarContr = (OKAppTabBarVC *)self.tabBarController;
    
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
    
    OKHttpRequestModel *model = nil;
    [OKHttpRequestTools sendOKRequest:model success:^(id returnValue) {
        
    } failure:^(NSError *error) {
        ShowAlertToast(error.domain);
    
    }];
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
            
            if (defaultNormolImageArr.count-1 < i) continue;
            
            //设置尺寸
            UIImage *convertImage = [UIImage scaleToSize:iconImage size:CGSizeMake(31*2, 31*2)];
            NSString *saveImagePath = [NSString stringWithFormat:@"%@/%@@2x.png",[OKUtils getTabBarDirectory],defaultNormolImageArr[i]];
            [UIImagePNGRepresentation(convertImage) writeToFile:saveImagePath atomically:NO];
            
            NSLog(@"下载图片是否保存成功===%@",saveImagePath);
            
            OKTabBarInfoModel *infoModel = [[OKTabBarInfoModel alloc] init];
            infoModel.tabBarItemTitle = @"测试";
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
