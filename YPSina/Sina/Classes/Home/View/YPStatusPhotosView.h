//
//  YPStatusPhotosView.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/26.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  cell上面的配图相册（里面会显示1~9张图片，里面都是YPStatusPhotoView）

#import <UIKit/UIKit.h>

@interface YPStatusPhotosView : UIView
/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(int)count;

@end
