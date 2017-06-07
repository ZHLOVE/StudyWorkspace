//
//  SecondViewController.h
//  ReactiveObjCDemo
//
//  Created by mao wangxin on 2017/5/19.
//  Copyright © 2017年 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

@interface SecondViewController : UIViewController

@property (nonatomic, strong) RACSubject *subject;

@end

