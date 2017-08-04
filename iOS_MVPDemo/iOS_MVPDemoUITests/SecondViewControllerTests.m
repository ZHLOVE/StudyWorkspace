//
//  SecondViewControllerTests.m
//  iOS_MVPDemo
//
//  Created by mao wangxin on 2017/8/4.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SecondViewController.h"

@interface SecondViewControllerTests : XCTestCase

@end

@implementation SecondViewControllerTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLoginBtnAction
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.keys[@"a"] tap];
    
    XCUIElement *pleaseInputUserNameTextField = app.textFields[@"please input user name"];
    [pleaseInputUserNameTextField typeText:@"a"];
    [app.keys[@"s"] tap];
    [pleaseInputUserNameTextField typeText:@"s"];
    [app.keys[@"d"] tap];
    [pleaseInputUserNameTextField typeText:@"d"];
    [app.otherElements[@"add"] tap];
    [app.buttons[@"login "] tap];
    
    
    
}

@end
