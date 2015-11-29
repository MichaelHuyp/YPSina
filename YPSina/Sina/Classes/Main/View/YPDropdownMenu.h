//
//  YPDropdownMenu.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/10.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPDropdownMenu;
@protocol YPDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(YPDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(YPDropdownMenu *)menu;
@end

/**
 *  自定义下拉菜单
 */
@interface YPDropdownMenu : UIView

@property (nonatomic, assign) id<YPDropdownMenuDelegate> delegate;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
/**
 *  创建下拉菜单
 */
+ (instancetype)menu;
/**
 *  显示下拉菜单
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁下拉菜单
 */
- (void)dismiss;


@end
