//
//  DataModel.h
//  XibDemo
//
//  Created by mao wangxin on 2017/6/6.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *weiboContent;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
