//
//  UIViewController+OKExtension.h
//  CommonFrameWork
//
//  Created by mao wangxin on 2017/1/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (OKExtension)

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(NSString *)title
                      target:(id)target
                    selector:(SEL)selector;

/**
 *  在导航栏左边增加控件
 */
- (void)addLeftBarButtonItem:(UIImage *)normolImage
                   highImage:(UIImage *)highImage
                      target:(id)target
                    selector:(SEL)selector;

/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(UIImage *)normolImage
                    highImage:(UIImage *)highImage
                       target:(id)target
                     selector:(SEL)selector;
/**
 *  在导航栏右边增加控件
 */
- (void)addRightBarButtonItem:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector;

/**
 *  设置导航右侧按钮点击状态
 */
- (void)setRightBarItemEnable:(BOOL)enable;

/**
 *  设置导航按右侧钮点击状态
 */
- (void)setNavRightBarItemEnable:(BOOL)enable titleColor:(UIColor *)color;

/**
 * 使用系统的返回按钮样式，
 * 注意：如果想要获取系统返回按钮的点击事件，
 * 可以打开《UINavigationController+OKExtension.m》类中的<navigationBar:shouldPopItem:>方法，
 * 在要操作的控制器中实现<navigationShouldPopOnBackButton>返回一个BOOL值来控制
 */
- (void)shouldUseSystemBackBtnStyle;

/**
 *  返回到指定控制器
 */
- (BOOL)shouldPopToCustomVC:(NSString *)classStr;

/**
 *  进入到指定控制器
 */
- (void)pushToCustomVC:(NSString *)classStr title:(NSString *)title;

/**
 *  此导航条仅供上一个页面没有导航栏, 下一个页面手势滑动边缘返回时会顶部异常的情况,
 *  在导航底部添加一个假的导航view
 */
- (void)showFakeNavBarWhenScreenEdgePanBack;

/**
 *  获取App最顶层的控制器
 */
+ (UIViewController *)currentTopViewController;


/**
 *  判断在导航栏控制器中有没存在该类
 *
 *  @param className 类名
 *
 *  @return 返回存在的控制器  没有存在则为nil
 */
- (UIViewController *)isExistClassInSelfNavigation:(NSString *)className;


/**
 带参数跳转到目标控制器, 如果导航栈中存在目标器则pop, 不存在则push
 
 @param vcName 目标控制器
 @param propertyDic 目标控制器属性字典
 @param selectorStr 跳转完成后需要执行的方法
 */
- (void)pushOrPopToViewController:(NSString *)vcName
                        aSelector:(NSString *)selectorStr
                       withObject:(NSDictionary *)propertyDic;

/**
 *  执行页面push跳转
 *
 *  @param vcName 当前的控制器
 *  @param propertyDic  控制器需要的参数
 */
- (void)pushToViewController:(NSString *)vcName propertyDic:(NSDictionary *)propertyDic;

/**
 *  执行页面present跳转
 *
 *  @param vcName 当前的控制器
 *  @param propertyDic 控制器需要的参数
 */
- (void)presentToViewController:(NSString *)vcName
                     withObject:(NSDictionary *)propertyDic
                  showTargetNav:(BOOL)showNavigation;

@end
