//
//  YPPlaceholderTextView.m
//  Sina
//
//  Created by 胡云鹏 on 15/9/1.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPPlaceholderTextView.h"

@implementation YPPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 不要设置自己的delegate为自己
//        self.delegate = self;
        
        // 通知
        // 当UITextView的文字发生改变时,UITextView自己会发出一个UITextViewTextDidChangeNotification通知

        [YPNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


/**
 *  用来监听文字改变
 */
- (void)textDidChange
{
    /**
     *  调用这个方法会重新调用drawRect方法进行重绘
     */
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

/**
 *  必须重写用代码修改文字内容的代码加上重绘代码
 *  这样可以保证重绘在某些非用户修改文字时通知不到的问题
 */
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 如果有输入文字就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:YPLightGrayColor;
    attributes[NSFontAttributeName] = self.font;
    // 画文字
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attributes];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attributes];
}

- (void)dealloc
{
    [YPNotificationCenter removeObserver:self];
}

@end
