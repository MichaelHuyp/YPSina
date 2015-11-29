//
//  YPItemTool.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/8.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPItemTool : NSObject
+ (UIBarButtonItem *)itemWithTarget:(id)target andAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage;
@end
