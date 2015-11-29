//
//  YPAccountTool.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/18.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

// 账号存储路径
#define YPAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "YPAccountTool.h"

@implementation YPAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(YPAccount *)account
{
    // 自定义对象的存储必须用 NSKeyedArchiver,不再有什么writeToFile方法了
    [NSKeyedArchiver archiveRootObject:account toFile:YPAccountPath];
}

/**
 *  返回账号信息
 *
 *  @return 账号模型(如果账号过期,返回nil)
 */
+ (YPAccount *)account
{
    // 加载模型
    YPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YPAccountPath];
    
    // 验证账号是否过期
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now -> 过期
    /**
     *  NSOrderedAscending = -1L, 升序 右边大
     *  NSOrderedSame,            相同
     *  NSOrderedDescending       降序 左边大
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
//    NSLog(@"%@ %@",expiresTime,now);
    return account;
}















@end
