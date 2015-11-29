//
//  YPAccountTool.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/18.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPAccount.h"
/**
 *  业务逻辑
 *  处理账号相关的所有操作:存储账号、取出账号、验证账号
 */
@interface YPAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(YPAccount *)account;
/**
 *  返回账号信息
 *
 *  @return 账号模型(如果账号过期,返回nil)
 */
+ (YPAccount *)account;

@end
