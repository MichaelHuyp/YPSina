//
//  YPStatusPhotosView.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/26.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPStatusPhotosView.h"
#import "YPPhoto.h"
#import "YPStatusPhotoView.h"
@implementation YPStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = (int)photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        // 创建缺少的imageView
        YPStatusPhotoView *photoView = [[YPStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        YPStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) { // 显示图片
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int photosCount = (int)self.photos.count;
    int maxCol = YPStatusPhotoMaxCol(photosCount);
    
    // 设置图片的尺寸和位置
    for (int i = 0; i < photosCount ; i++) {
        YPStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (YPStatusPhotoWH + YPStatusPhotoMargin);
        int row = i / maxCol;
        photoView.y = row * (YPStatusPhotoWH + YPStatusPhotoMargin);
        photoView.width = YPStatusPhotoWH;
        photoView.height = YPStatusPhotoWH;
    }
}

// 行数
//    int rows = 0;
//    if (count % 3 == 0) { // 可以整除 3 / 6 / 9
//        rows = count / 3
//    } else { // 不能整除 1 / 2 / 4 / 5 / 7 / 8
//        rows = count / 3 + 1;
//    }

//    int rows = count / 3;
//    if (count % 3 != 0) {
//        rows += 1;
//    }
+ (CGSize)sizeWithCount:(int)count
{
    /**
     *  重要公式 count 总记录数 maxCols每页最大数
     */
    
    // 最大列数（一行最多有多少列）
    int maxCols = YPStatusPhotoMaxCol(count);
    
    // 列数
    int cols = (count >= maxCols)? maxCols : count;
    
    CGFloat photosW = cols * YPStatusPhotoWH + (cols - 1) * YPStatusPhotoMargin;
    
    // 行数
    int rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photosH = rows * YPStatusPhotoWH + (rows - 1) * YPStatusPhotoMargin;
    
    
    return CGSizeMake(photosW, photosH);
}


















@end
