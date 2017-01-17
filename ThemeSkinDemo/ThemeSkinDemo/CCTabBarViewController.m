//
//  CCTabBarViewController.m
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2016/12/24.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "CCTabBar.h"
#import "CCConst.h"

//定义UIImage对象，图片多次被使用到
#define ImageNamed(name)                [UIImage imageNamed:name]
//rgb颜色
#define RGB(r,g,b)                      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f                                                                                 alpha:1.f]
//rgb颜色,  a:透明度
#define RGBA(r,g,b,a)                   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f                                                                                 alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define UIColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//主色 (黄色)
#define Color_Main                      UIColorFromRGB(0xfe9b00)

@interface CCTabBarViewController ()
@property (nonatomic, strong) CCTabBar *appTabBar;
@end

@implementation CCTabBarViewController

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
    
    //设置默认tabBar图片
    [self setDefaultTabBarImages];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"app TabBar对象===%@",self);
    
    //初始化tabBar控制器
    [self initTabBarVC];
}

/**
 * 初始化tabBar控制器
 */
- (void)initTabBarVC
{
    //1. 添加子控制器: 首页, 发现, 我的
    [self addTabBarChildVC:[FirstViewController new]];
    [self addTabBarChildVC:[SecondViewController new]];
    [self addTabBarChildVC:[ThirdViewController new]];
    
    //2. 更换tabBar
    [self setValue:self.appTabBar forKeyPath:@"tabBar"];
}

/**
 * 自定义添加双击事件和主题图标
 */
- (CCTabBar *)appTabBar
{
    if (!_appTabBar) {
        _appTabBar = [[CCTabBar alloc] init];
    }
    return _appTabBar;
}


/**
 * 初始化子控制器tabBar默认图片
 */
- (void)addTabBarChildVC:(UIViewController *)vc
{
    // 设置文字和图片
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置tabBar文字颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x8CC63F),NSForegroundColorAttributeName, nil];
    [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


/**
 * 设置默认tabBar图片
 */
- (void)setDefaultTabBarImages
{
    NSMutableArray *defaultTabBarImageArr = [NSMutableArray array];
    
    NSArray *defaultTitleArray = @[@"首页",@"发现",@"我的"];
    NSArray *defaultNormolImageArr = @[@"tabbar_home_n",@"tabbar_property_n",@"tabbar_my_n"];
    NSArray *defaultSelectImageArr = @[@"tabbar_home_h",@"tabbar_property_h",@"tabbar_my_h"];
    
    NSInteger index = 0;
    for (UINavigationController *childNav in self.childViewControllers) {
        UIViewController *childVC = [childNav.viewControllers firstObject];
        childVC.navigationItem.title = defaultTitleArray[index];
        childNav.tabBarItem.title = defaultTitleArray[index];
        
        NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
        infoDic[CCTabBarItemTitleKey] = defaultTitleArray[index];
        infoDic[CCTabBarNormolImageKey] = [UIImage imageNamed:defaultNormolImageArr[index]];
        infoDic[CCTabBarSelectedImageKey] = [UIImage imageNamed:defaultSelectImageArr[index]];
        
        [defaultTabBarImageArr addObject:infoDic];
        index++;
    }
    [self.appTabBar setTabBarItemImages:defaultTabBarImageArr];
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

//更换主题
- (void)changeTabbarItemCustomImages:(NSArray *)customImageArr
{
    [self.appTabBar setTabBarItemImages:customImageArr];
}

@end
