//
//  YPStatusToolbar.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/25.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  微博cell工具条

#import <UIKit/UIKit.h>
@class YPStatus;
@interface YPStatusToolbar : UIView

@property (nonatomic, strong) YPStatus *status;

+ (instancetype)toolbar;

@end
