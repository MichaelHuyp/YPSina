//
//  YPUser.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/20.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  

#import "YPUser.h"

@implementation YPUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//- (BOOL)isVip
//{
//    return self.mbtype > 2;
//}

@end
