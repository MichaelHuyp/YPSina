//
//  YPStatus.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/20.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class YPUser;
@interface YPStatus : NSObject
/**
 *  string	字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  string	微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/** 微博的信息内容 -- 带有属性的（特殊文字会高亮显示、带有表情）*/
@property (nonatomic, copy) NSAttributedString *attributedtext;

/**
 *  object	微博作者的用户信息字段
 */
@property (nonatomic, strong) YPUser *user;
/**
 *  string	微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  string	微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  object  微博配图地址。多图时返回多图连接。无配图返回"[]"
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  object	被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property (nonatomic, strong) YPStatus *retweeted_status;

/** 被转发微博的 信息内容 */
@property (nonatomic, copy) NSAttributedString *retweetedAttributedtext;

/**
 *  int 转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  int 评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  int 点赞数
 */
@property (nonatomic, assign) int attitudes_count;













@end
