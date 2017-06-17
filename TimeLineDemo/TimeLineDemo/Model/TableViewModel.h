//
//  TableViewModel.h
//  Weixin_TimeLine
//
//  Created by Luke on 2017/6/17.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Postlist;
@class Post;
@class Imagelist;

@interface Imagelist : NSObject
/** <#属性注释#> */
@property (nonatomic, copy) NSString *username;
@end

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
@property (nonatomic, strong) NSArray<Imagelist *> *imageList;
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


@interface Postlist : NSObject

/** <#属性注释#> */
@property (nonatomic, strong) Post *post;
/** <#属性注释#> */
@property (nonatomic, copy) NSString *postType;
@end


@interface TableDataModel : NSObject

/** <#属性注释#> */
@property (nonatomic, strong) NSArray<Postlist *> *postList;
/** <#属性注释#> */
@property (nonatomic, assign) NSInteger errorCode;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end

/**
 *  视图逻辑处理器
 */
@interface TableViewModel : NSObject

@end
