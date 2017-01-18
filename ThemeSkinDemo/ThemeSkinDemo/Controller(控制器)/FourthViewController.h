//
//  FourthViewController.h
//  ThemeSkinDemo
//
//  Created by mao wangxin on 2017/1/10.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewController : UIViewController

//刷新数据1
- (void)refreshUI1WithData:(id)requestData;

//刷新数据2
- (void)refreshUI2WithData:(id)requestData;

//刷新数据3
- (void)refreshUI3WithData:(id)requestData;

//滚动到顶部
- (void)scrollToTop;

@end
