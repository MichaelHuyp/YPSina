//
//  YPStatusPhotoView.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/27.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPStatusPhotoView.h"
#import "YPPhoto.h"
#import "UIImageView+WebCache.h"

@interface YPStatusPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation YPStatusPhotoView

- (UIImageView *)gifView
{
    if (_gifView == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        // initWithImage可以保证UIImageView的尺寸初始化时等于Image的尺寸
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YPRedColor;
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容减掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(YPPhoto *)photo
{
    _photo = photo;
    
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 显示\隐藏gif控件
    // 先将字符串整体转为小写然后判断尾缀
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}



@end
