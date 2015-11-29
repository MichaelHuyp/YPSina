//
//  YPTitleButton.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/20.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPTitleButton.h"

#define YPMargin 5

@implementation YPTitleButton

+ (instancetype)titleButton
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width += YPMargin;
    [super setFrame:frame];
}

/**
 *  计算子控件位置的方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /**
     *  如果仅仅是调整按钮内部titleLabel和imageView的位置
     *  那么在layoutSubviews中单独设置位置即可
     */
    
    // 1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    
    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + YPMargin;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 设置按钮自适应（尺寸适应里面内容）
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    // 设置按钮自适应（尺寸适应里面内容）
    [self sizeToFit];
}













@end
