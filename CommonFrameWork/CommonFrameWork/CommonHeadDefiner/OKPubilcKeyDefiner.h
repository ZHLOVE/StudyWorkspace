//
//  OKPubilcKeyDefiner.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#ifndef OKPubilcKeyDefiner_h
#define OKPubilcKeyDefiner_h

//----------------------公共通用宏---------------------------

/** 登录后保存的用户ID, 保存的value为 NSString 类型*/
#define UserIDUserDefaultsKey               @"operatorId"

/** 数据库名称 */
#define AppFMDBName                         @"OKDB.sqlite"

/** 钱币符号 */
#define OK_Money_header                     @"￥"


/* 获取iOS系统版本 */
#define KsystemVersion                      [[[UIDevice currentDevice] systemVersion] floatValue]
/*  获取App版本号 */
#define XcodeAppVersion                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/*  弱引用 */
#define WEAKSELF                            typeof(self) __weak weakSelf = self;
/*  强引用 */
#define STRONGSELF                          typeof(weakSelf) __strong strongSelf = weakSelf;

//定义UIImage对象，图片多次被使用到
#define ImageNamed(name)                    [UIImage imageNamed:name]

// 是否支持手势右滑返回
#define PopGestureRecognizerenabled(ret)   (self.navigationController.interactivePopGestureRecognizer.enabled = ret)


//自定义字体大小
//字体的大小
#undef  FontCustomSize
#define FontCustomSize(fontName,fontSize)   ([UIFont fontWithName:fontName size:fontSize])

//定义(细体字)
#undef  FontThinSize
#define FontThinSize(fontSize)              [UIFont fontWithName:@"Heiti SC" size:fontSize]

//设置系统默认字体的大小
#undef  FONTSYSTEM
#define FONTSYSTEM(fontSize)                ([UIFont systemFontOfSize:fontSize])

//设置系统加粗字体的大小
#undef  FONTBOLDSYSTEM
#define FONTBOLDSYSTEM(fontSize)            ([UIFont boldSystemFontOfSize:fontSize])

//获取 appdelegate
#define APPDELEGATE                         (AppDelegate *)[[UIApplication sharedApplication] delegate]

//默认数据加载失败
#define DefaultRequestError                  [NSError errorWithDomain:@"数据加载失败" code:502 userInfo:nil]

/*---------------------打印日志--------------------------*/
//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:\n%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina                                    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//检查系统版本   equal相等   greater大 less 小
#define System_Version_Equal_To(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define System_Version_Greater_Than(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define System_Version_Greater_Than_Or_Equal_To(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define System_Version_Less_Than(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define System_Version_Less_Than_Or_Equal_To(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*----------------------- 设置App字体 -------------------------*/
//设置自定义细体字
#define FontThinCustomSize(s)               [UIFont fontWithName:@"Heiti SC" size:s]

//设置系统普通字体
#define FontSystemSize(s)                   [UIFont systemFontOfSize:s]

//设置系统粗体字体
#define FontBoldSize(s)                     [UIFont boldSystemFontOfSize:s]


/*----------------------适配屏幕----------------------------*/
#define IS_IPHONE4      (([[UIScreen mainScreen] bounds].size.height == 480) ? YES : NO)
#define IS_IPHONE_5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE5      (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
#define IS_IPhone6      (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define IS_IPhone6plus  (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)


//判空对象
#define isNull(obj)     (((NSNull *)obj == [NSNull null])?YES:NO)

/** 保存数据到偏好设置 */
#define SaveUserDefault(key,Obj) \
({  if (!isNull(key) && !isNull(Obj) && key != nil  && Obj != nil) { \
[[NSUserDefaults standardUserDefaults] setObject:Obj forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; } \
})

/** 获取偏好设置数据 */
#define GetUserDefault(key)  key!=nil ? [[NSUserDefaults standardUserDefaults] objectForKey:key] : nil


/*----------------------忽略警告的宏----------------------------*/
/**
 * 忽略警告的宏
 * 忽略警告的类型: [obj performSelector: withObject:]
 * 使用方式:
 OKPerformSelectorLeakWarning(
 [popTargetVC performSelector:selector withObject:nil];
 );
 */
#define OKPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#define OKUndeclaredSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/**
 * 拷贝自定义对象,NSCopy协议的具体实现
 */
#define OKCopyImplementation \
- (id)copyWithZone:(NSZone *)zone \
{ \
Class clazz = [self class]; \
id model = [[clazz allocWithZone:zone] init]; \
[clazz mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {\
id obj = [self valueForKey:property.name];\
[model setValue:obj forKey:property.name];\
}];\
return model;\
}

//一个宏实现自定义对象的NSCopy协议
#define OKExtensionCopyImplementation  OKCopyImplementation



#endif /* OKPubilcKeyDefiner_h */
