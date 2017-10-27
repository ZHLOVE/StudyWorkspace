//
//  StudyUserDefaultVC.m
//  ApiDemo
//
//  Created by mao wangxin on 2017/10/27.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "StudyUserDefaultVC.h"

@interface StudyUserDefaultVC ()

@end

@implementation StudyUserDefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    UIRefreshControl *refreshcontrol;
//    UITableViewController *tabController;
//    UITableView *tableView;
//    UIScrollView *scrollView;

}

- (void)userDefaultApi {
    /**
    // 同步对共享对象的任何更改默认用户和从内存中释放它。
    resetStandardUserDefaults
    // 返回共享默认对象。
    + (NSUserDefaults *)standardUserDefaultsaddSuiteNamed：
    // 插入到接收器的搜索列表中指定的域名。
    - (void)addSuiteNamed:( NSString *) suiteName
    // 返回与指定键相关联的数组。
    - ( NSArray *)arrayForKey:( NSString *) defaultName
    // 返回布尔值与指定键相关联。
    - (BOOL)boolForKey:( NSString *) defaultName
    // 返回数据对象与指定键相关联。
    - ( NSData *)dataForKey:( NSString *) defaultName
    // 返回Dictionary对象与指定键相关联。
    - ( NSDictionary *)dictionaryForKey:( NSString *) defaultName
    // 返回一个字典，它包含在搜索列表中的域的所有键值对联盟。（ NSData ， NSString ， NSNumber ， NSDate ，NSArray ，或NSDictionary ）
    - ( NSDictionary *)dictionaryRepresentation
    // 消除了在标准应用程序域指定的默认??键值。
    - (void)removeObjectForKey:( NSString *) defaultName
    // 删除指定的从用户的默认持久域的内容。
    - (void)removePersistentDomainForName:( NSString *) domainName
    // 设置指定的默认??键到指定的布尔值。
    - (void)setBool:(BOOL) value forKey:( NSString *) defaultName
    // 设置为指定的字典持久域。
    - (void)setPersistentDomain:( NSDictionary *) domain forName:( NSString *) domainName
    // 设置指定的默认??键到指定的URL值。
    - (void)setURL:( NSURL *) url forKey:( NSString *) defaultName
    // 设置为指定的字典挥发性域。
    - (void)setVolatileDomain:( NSDictionary *) domain forName:( NSString *) domainName
    // 返回与指定键关联的字符串数组。
    - ( NSArray *)stringArrayForKey:( NSString *) defaultName
    // 返回与指定键关联的字符串。
    - ( NSString *)stringForKey:( NSString *) defaultName
    //返回NSURL实例与指定键相关联。
    - ( NSURL *)URLForKey:( NSString *) defaultName
    // 返回double值与指定键相关联。
    - (double)doubleForKey:( NSString *) defaultName
    // 返回浮点值与指定键相关联。
    - (float)floatForKey:( NSString *) defaultName
    // 返回NSUserDefaults对象初始化的用户帐户的默认为指定的。
    - (id)initWithUser:( NSString *) username
    // 返回整数值与指定键关联..
    - （ NSInteger NSInteger )integerForKey:( NSString *) defaultName
    // 返回与指定默认的第一个发生关联的对象。
    - (id)objectForKey:( NSString *) defaultName
    // 判断此key是否存在
    - (BOOL)objectIsForcedForKey:( NSString *) key

     */
}

/**
 * 例子
 */
- (void)example1
{
    // 官方规定类型使用
    // 获取一个NSUserDefaults引用：
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 保存数据
    [userDefaults setInteger:1 forKey:@"thyKey"];
    [userDefaults synchronize];
    // 读取数据
    NSInteger i = [userDefaults integerForKey:@"thyKey"];
    NSLog(@"读取数据===%zd",i);

    // 其他类型使用（如一个类等）
    // 保存数据：
    NSData *objColor1 = [NSKeyedArchiver archivedDataWithRootObject:[UIColor redColor]];
    [[NSUserDefaults standardUserDefaults]setObject:objColor1 forKey:@"thyColor"];

    // 读取数据：
    NSData *objColor2 = [userDefaults objectForKey:@"thyColor"];
    UIColor *myColor = [NSKeyedUnarchiver unarchiveObjectWithData:objColor2];
}

@end
