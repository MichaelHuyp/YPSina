//
//  YPTextPart.h
//  Sina
//
//  Created by 胡云鹏 on 15/10/23.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  文字的一部分

#import <Foundation/Foundation.h>

@interface YPTextPart : NSObject

/** 这段文字的内容 */
@property (nonatomic, copy) NSString *text;

/** 这段文字的范围 */
@property (nonatomic, assign) NSRange range;

/** 是否为特殊文字 */
@property (nonatomic, assign, getter=isSpecial) BOOL special;

/** 是否为表情 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
