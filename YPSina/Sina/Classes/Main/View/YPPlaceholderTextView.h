//
//  YPPlaceholderTextView.h
//  Sina
//
//  Created by 胡云鹏 on 15/9/1.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  增强:带有占位文字的UITextView
#import <UIKit/UIKit.h>

@interface YPPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
