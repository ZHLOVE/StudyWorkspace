//
//  NSNull+OKSafely.h
//  OkdeerUser
//
//  Created by mao wangxin on 2016/11/24.
//  Copyright © 2016年 OkdeerUser. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  防止服务端数据返回NSNull时,客户端操作导致的崩溃
 */
@interface NSNull (OKSafely)

@end
