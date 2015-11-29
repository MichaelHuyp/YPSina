//
//  YPItemTool.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/8.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPItemTool.h"

@implementation YPItemTool
/**
 *  创建一个item
 *
 *  @param action    点击item后调用的方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target andAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
