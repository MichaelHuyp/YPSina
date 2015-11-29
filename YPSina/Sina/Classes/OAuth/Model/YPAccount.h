//
//  YPAccount.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/18.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPAccount : NSObject <NSCoding>
/**
 *  用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSNumber *expires_in;
/**
 *  当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  access token的创建时间
 */
@property (nonatomic, strong) NSDate *created_time;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
