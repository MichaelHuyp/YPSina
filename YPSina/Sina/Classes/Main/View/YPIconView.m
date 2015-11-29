//
//  YPIconView.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/27.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPIconView.h"
#import "YPUser.h"
#import "UIImageView+WebCache.h"

@interface YPIconView()
/**
 *  认证图标
 */
@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation YPIconView

- (UIImageView *)verifiedView
{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setUser:(YPUser *)user
{
    _user = user;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.设置加V图片
    switch (user.verified_type) {
        case YPUserVerifiedTypePersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case YPUserVerifiedTypeOrgEnterprice:
        case YPUserVerifiedTypeOrgMedia:
        case YPUserVerifiedTypeOrgWebsite: // 企业认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case YPUserVerifiedTypeDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES; // 没有任何认证
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

@end
