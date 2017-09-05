//
//  TimeLineViewModel.h
//  TimeLineDemo
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Postlist;
@class Post;

@interface Post : NSObject

/** <#属性注释#> */
@property (nonatomic, copy) NSString *username;
/** <#属性注释#> */
@property (nonatomic, assign) NSInteger userGrade;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *reply;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *title;
/** <#属性注释#> */
@property (nonatomic, strong) NSArray *imageList;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *watch;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *boardId;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *bbs;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *manuId;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *productId;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *good;
/** <#属性注释#> */
@property (nonatomic, assign) NSInteger isAdmin;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *userIcon;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *bookId;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *subId;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *boardname;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *lastdate;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *content;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *userId;
@end


@interface TimeLineDataModel : NSObject

/** <#属性注释#> */
@property (nonatomic, strong) Post *post;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *postType;
/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

//利用Xib计算Cell高度
- (void)calculateCellHeight;

@end

/**
 *  视图逻辑处理器
 */
@interface TimeLineViewModel : NSObject

@end

