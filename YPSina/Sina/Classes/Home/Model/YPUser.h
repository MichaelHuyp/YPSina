//
//  YPUser.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/20.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

typedef enum {
    /**
     *  普通注册用户,没有任何认证
     */
    YPUserVerifiedTypeNone = -1,
    /**
     *  个人认证
     */
    YPUserVerifiedTypePersonal = 0,
    /**
     *  企业官方认证
     */
    YPUserVerifiedTypeOrgEnterprice = 2,
    /**
     *  媒体官方认证
     */
    YPUserVerifiedTypeOrgMedia = 3,
    /**
     *  网站官方认证
     */
    YPUserVerifiedTypeOrgWebsite = 5,
    /**
     *  微博达人
     */
    YPUserVerifiedTypeDaren = 220
} YPUserVerifiedType;

@interface YPUser : NSObject
/**
 *  string	字符串型的用户UID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  string	友好显示名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  string	用户头像地址（中图），50×50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  会员类型 值 > 2 才代表是会员
 */
@property (nonatomic, assign) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign,getter= isVip) BOOL vip;

/**
 *  认证类型
 */
@property (nonatomic, assign) YPUserVerifiedType verified_type;















@end
