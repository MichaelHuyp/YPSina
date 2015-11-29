//
//  YPDropdownMenu.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/10.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPDropdownMenu.h"

@interface YPDropdownMenu()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;
@end

@implementation YPDropdownMenu

// 简单封装下拉菜单 19:10
- (UIImageView *)containerView
{
    if (_containerView == nil) {
        // 添加带箭头的灰色图片
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}
/**
 *  创建下拉菜单
 */
+ (instancetype)menu
{
    return [[self alloc] init];
}
/**
 *  显示下拉菜单
 */
- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 2.添加自己到窗口上
    [window addSubview:self];
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    // 通知外界,自己显示了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)])
    {
        [self.delegate dropdownMenuDidShow:self];
    }
}
/**
 *  销毁下拉菜单
 */
- (void)dismiss
{
    [self removeFromSuperview];
    
    // 通知外界,自己被销毁了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)])
    {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    
    // 调整内容的宽度
//    content.width = self.containerView.width - 2 * content.x;
    
    // 设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    
    // 设置灰色的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
    
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}














@end
