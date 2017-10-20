//
//  StudyInvocationVC.m
//  ApiDemo
//
//  Created by mao wangxin on 2017/6/12.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "StudyInvocationVC.h"
#import <OKAlertView.h>

@interface StudyInvocationVC ()

@end

@implementation StudyInvocationVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //使用系统的返回按钮样式
    [self testNavBackBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    showAlertToast(@"查看控制台打印日志");
    
    //NSInvocation的使用
    [self testNSInvocation];
    
    //使用系统的返回按钮样式
    [self testNavBackBtn];
    
}

/**
 * 使用系统的返回按钮样式
 */
- (void)testNavBackBtn
{
    //设置返回按钮图片
    UIImage *backImage = [UIImage imageNamed:@"backBarButtonItemImage"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage;
    self.navigationController.navigationBar.backIndicatorImage = backImage;
    
    //设置返回按钮标题
    self.navigationController.navigationBar.backItem.title = @"";
    
    UIBarButtonItem *item = self.navigationItem.backBarButtonItem;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UINavigationItem *backItem = self.navigationController.navigationBar.backItem;
    
    NSLog(@"backItem===%@===%@===%@",backItem,item,navigationBar);
}

/**
 * 控制系统返回按钮是否能点击返回
 */
- (BOOL)navigationShouldPopOnBackButton
{
    OKAlertSingleBtnView(@"提示", @"查看控制台打印日志", @"好的");
    return YES;
}


/**
 * NSInvocation的使用
 * 用来包装方法和对应的对象，它可以存储方法的名称，对应的对象，对应的参数
 */
- (void)testNSInvocation
{
    /*
     NSMethodSignature：签名：再创建NSMethodSignature的时候，必须传递一个签名对象，签名对象的作用：用于获取参数的个数和方法的返回值
     */
    
    //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
    NSMethodSignature*signature = [StudyInvocationVC instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:WithContent:)];
    
    //1、创建NSInvocation对象
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = self;
    
    //invocation中的方法必须和签名中的方法一致。
    invocation.selector = @selector(sendMessageWithNumber:WithContent:);
    
    /*第一个参数：需要给指定方法传递的值
     第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
    //第二个参数：需要给指定方法的第几个参数传值
    NSString *number = @"1111";
    
    //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
    [invocation setArgument:&number atIndex:2];
    
    NSString *number2 = @"啊啊啊";
    [invocation setArgument:&number2 atIndex:3];
    
    //2、调用NSInvocation对象的invoke方法
    //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
}


- (void)sendMessageWithNumber:(NSString*)number WithContent:(NSString*)content{
    NSLog(@"电话号%@,内容%@",number,content);
}

/**
 * 测试@try @catch方法
 */
- (void)testTryCatchMethod
{
    @try {
        NSLog(@"===try===");
        //Code that can potentially throw an exception
        [self performSelector:@selector(hahaha) withObject:nil];
        
    } @catch (NSException *exception) {
        //Handle an exception thrown in the @try block
        NSLog(@"===exception===%@",exception);
        
    } @finally {
        //Code that gets executed whether or not an exception is thrown
        NSLog(@"===finally===");
    }
}

@end
