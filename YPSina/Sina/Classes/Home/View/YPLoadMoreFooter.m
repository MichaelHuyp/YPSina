//
//  YPLoadMoreFooter.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/20.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPLoadMoreFooter.h"

@implementation YPLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
