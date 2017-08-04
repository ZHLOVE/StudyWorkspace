//
//  FirstViewController.h
//  iOS_MVPDemo
//
//  Created by mao wangxin on 2017/8/3.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import "OKBaseViewController.h"
#import "ListDataPresenter.h"

@interface FirstViewController : OKBaseViewController

@property (nonatomic, strong) ListDataPresenter *presenter;

@end

