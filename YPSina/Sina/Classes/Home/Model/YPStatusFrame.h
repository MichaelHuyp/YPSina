//
//  YPStatusFrame.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/23.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  一个YPStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放着一个cell的高度
//  3.存放着一个数据模型YPStatus

#import <Foundation/Foundation.h>

@class YPStatus;

@interface YPStatusFrame : NSObject

@property (nonatomic, strong) YPStatus *status;

/**
 *  原创微博整体
 */
@property (nonatomic, assign) CGRect originalViewF;
/**
 *  头像
 */
@property (nonatomic, assign) CGRect iconViewF;
/**
 *  会员图标
 */
@property (nonatomic, assign) CGRect vipViewF;
/**
 *  配图
 */
@property (nonatomic, assign) CGRect photosViewF;
/**
 *  昵称
 */
@property (nonatomic, assign) CGRect nameLabeLF;
/**
 *  时间
 */
@property (nonatomic, assign) CGRect timeLabeLF;
/**
 *  来源
 */
@property (nonatomic, assign) CGRect sourceLabeLF;
/**
 *  正文
 */
@property (nonatomic, assign) CGRect contentLabeLF;


/**
 *  转发微博整体
 */
@property (nonatomic, assign) CGRect retweetViewF; 
/**
 *  转发微博正文 + 昵称
 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/**
 *  转发配图
 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;


/**
 *  底部工具条
 */
@property (nonatomic, assign) CGRect toolbarF;


/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
