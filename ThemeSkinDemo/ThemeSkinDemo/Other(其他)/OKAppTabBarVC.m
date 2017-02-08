//
//  CCTabBarViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "OKAppTabBarVC.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "OKTabBarInfoModel.h"
#import "OKAppTabBar.h"
#import "OKBaseNavigationVC.h"
#import "OKFileManager.h"
#import "LeftViewController.h"

@interface OKAppTabBarVC ()
@property (nonatomic, strong) OKAppTabBar *appTabBar;
@end

@implementation OKAppTabBarVC

/** 可以设置UITabBarItem的通用主题
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //默认只设置一次tabBar初始图片
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setDefaultTabBarImages];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"系统TabBar对象===%@",self.tabBar);
    
    //初始化tabBar控制器
    [self initTabBarVC];
}

/**
 * 初始化tabBar控制器
 */
- (void)initTabBarVC
{
    //添加子控制器: 首页
    [self addTabBarChildVC:[LeftViewController new] navTitle:@"首页"];
    
    //添加子控制器: 发现
    [self addTabBarChildVC:[SecondViewController new] navTitle:@"发现"];
    
    //添加子控制器: 我的
    [self addTabBarChildVC:[ThirdViewController new] navTitle:@"我的"];
    
    //更换tabBar，为什么要更换，因为可以自定义双击事件,自定义换肤等
    [self setValue:self.appTabBar forKeyPath:@"tabBar"];
}

/**
 * 自定义添加双击事件和主题图标
 */
- (OKAppTabBar *)appTabBar
{
    if (!_appTabBar) {
        _appTabBar = [[OKAppTabBar alloc] initWithFrame:self.tabBar.bounds];
        WEAKSELF //重复点击tabBar回调
        [_appTabBar setRepeatTouchDownItemBlock:^(UITabBarItem *item) {
            [weakSelf didRepeatTouchDownTabBarItem:item];
        }];
        NSLog(@"自定义TabBar对象===%@",_appTabBar);
    }
    return _appTabBar;
}

/**
 * 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
 */
- (void)addTabBarChildVC:(UIViewController *)vc navTitle:(NSString *)navTitle
{
    // 设置控制器起始位置和标题
    OKBaseNavigationVC *nav = [[OKBaseNavigationVC alloc] initWithRootViewController:vc];
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    vc.navigationItem.title = navTitle;
    [self addChildViewController:nav];
}

/**
 * 设置tabBar主题图片
 */
- (void)setDefaultTabBarImages
{
    NSMutableArray *tabBarImageArr = [NSMutableArray array];
    
    NSArray *defaultTitleArray = @[@"首页",@"发现",@"我的"];
    NSArray *defaultNormolImageArr = @[@"tabbar_home_n",@"tabbar_property_n",@"tabbar_my_n"];
    NSArray *defaultSelectImageArr = @[@"tabbar_home_h",@"tabbar_property_h",@"tabbar_my_h"];
    
    //先加载沙盒的tabBar图标
    for (int i=0; i<defaultNormolImageArr.count; i++) {
        NSString *iconPath = [NSString stringWithFormat:@"%@/%@@2x.png",[OKFileManager getTabBarDirectory],defaultNormolImageArr[i]];
        
        BOOL hasFile = [[NSFileManager defaultManager] fileExistsAtPath:iconPath];
        if (!hasFile) continue;
        
        UIImage *image = [UIImage imageNamed:iconPath];
        if (![image isKindOfClass:[UIImage class]]) continue;
        OKTabBarInfoModel *infoModel = [[OKTabBarInfoModel alloc] init];
        
        infoModel.tabBarItemTitle = defaultTitleArray[i];
        infoModel.tabBarNormolImage = image;
        infoModel.tabBarSelectedImage = image;
        infoModel.tabBarNormolTitleColor = UIColorFromHex(0x282828);
        infoModel.tabBarSelectedTitleColor = UIColorFromHex(0xfe9b00);
        infoModel.tabBarTitleOffset = -10;
        infoModel.tabBarImageOffset = -20;
        
        [tabBarImageArr addObject:infoModel];
    }
    
    //数据不对就加载默认图标
    if (tabBarImageArr.count < self.childViewControllers.count) {
        [tabBarImageArr removeAllObjects];
        
        for (int i=0; i<self.childViewControllers.count; i++) {
            OKTabBarInfoModel *infoModel = [[OKTabBarInfoModel alloc] init];
            
            infoModel.tabBarItemTitle = defaultTitleArray[i];
            infoModel.tabBarNormolImage = ImageNamed(defaultNormolImageArr[i]);
            infoModel.tabBarSelectedImage = ImageNamed(defaultSelectImageArr[i]);
            infoModel.tabBarNormolTitleColor = [UIColor blackColor];
            infoModel.tabBarSelectedTitleColor = UIColorFromHex(0x8CC63F);
            
            [tabBarImageArr addObject:infoModel];
        }
    }
    
    //更换tabBar图片
    [self changeTabBarThemeImages:tabBarImageArr];
}

#pragma mark - 监听tabBar双击事件

/**
 * 监听重复点击tabBar按钮事件
 */
- (void)didRepeatTouchDownTabBarItem:(UITabBarItem *)item
{
    NSInteger touchIndex = [self.tabBar.items indexOfObject:item];
    if (self.viewControllers.count > touchIndex) {
        UIViewController *touchItemVC = self.viewControllers[touchIndex];
        
        if ([touchItemVC isKindOfClass:[UINavigationController class]]) {
            touchItemVC = [((UINavigationController *)touchItemVC).viewControllers firstObject];
        }
        //忽略警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([touchItemVC respondsToSelector:@selector(repeatTouchTabBarToViewController:)]) {
            [touchItemVC performSelector:@selector(repeatTouchTabBarToViewController:) withObject:touchItemVC];
        }
#pragma clang diagnostic pop
    }
}

#pragma mark - 给tabbar切换主题图片

/**
 * 更换主题
 */
- (void)changeTabBarThemeImages:(NSArray <OKTabBarInfoModel *> *)customImageArr
{
    [self.appTabBar setTabBarItemImages:customImageArr];
}

@end
