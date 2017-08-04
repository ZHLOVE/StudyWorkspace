//
//  iOS_MVPDemoTests.m
//  iOS_MVPDemoTests
//
//  Created by mao wangxin on 2017/8/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListDataPresenter.h"

@interface iOS_MVPDemoTests : XCTestCase
@property (nonatomic, strong) ListDataPresenter *presenter;
@end

@implementation iOS_MVPDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // 实例化需要测试的类
    self.presenter = [[ListDataPresenter alloc] init];
}

/**
 
 //生成一个失败的测试；
 XCTFail(format…)
 
 //为空判断，a1为空时通过，反之不通过；
 XCTAssertNil(a1, format...)
 
 //不为空判断，a1不为空时通过，反之不通过；
 XCTAssertNotNil(a1, format…)
 
 //当expression求值为TRUE时通过；
 XCTAssert(expression, format...)
 
 //当expression求值为TRUE时通过；
 XCTAssertTrue(expression, format...)
 
 //当expression求值为False时通过；
 XCTAssertFalse(expression, format...)
 
 //判断相等，[a1 isEqual:a2]值为TRUE时通过，其中一个不为空时，不通过；
 XCTAssertEqualObjects(a1, a2, format...)
 
 //判断不等，[a1 isEqual:a2]值为False时通过；
 XCTAssertNotEqualObjects(a1, a2, format...)
 
 //判断相等（当a1和a2是 C语言标量、结构体或联合体时使用, 判断的是变量的地址，如果地址相同则返回TRUE，否则返回NO）；
 XCTAssertEqual(a1, a2, format...)
 
 //判断不等（当a1和a2是 C语言标量、结构体或联合体时使用）；
 XCTAssertNotEqual(a1, a2, format...)
 
 //判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/-accuracy）以内相等时通过测试；
 XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...)
 
 //判断不等，（double或float类型）提供一个误差范围，当在误差范围以内不等时通过测试；
 XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...)
 
 //异常测试，当expression发生异常时通过；反之不通过；（很变态）
 XCTAssertThrows(expression, format...)
 
 // 异常测试，当expression发生specificException异常时通过；反之发生其他异常或不发生异常均不通过；
 XCTAssertThrowsSpecific(expression, specificException, format...)
 
 //异常测试，当expression发生具体异常、具体异常名称的异常时通过测试，反之不通过；
 XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...)
 
 //异常测试，当expression没有发生异常时通过测试；
 XCTAssertNoThrow(expression, format…)
 
 //异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过；
 XCTAssertNoThrowSpecific(expression, specificException, format...)
 
 //异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过
 XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...)
 */

- (void)tearDown {
    // 清空
    self.presenter = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddMethod
{
    //设置变量和设置预期值
    NSUInteger a = 10;NSUInteger b = 15;
    NSUInteger expected = 25;
    //执行方法得到实际值
    NSUInteger actual = a + b;
    //断言判定实际值和预期是否符合
    XCTAssertEqual(expected, actual,@"testAddMethod方法错误！");
}

- (void)testExample {
    
    // 调用需要测试的方法，
    [self.presenter reqPageListData:YES callBack:^(NSArray *array) {
       
        // 如果不相等则会提示@“测试不通过”
        XCTAssertNotNil(array,@"测试通过");
    }];
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
