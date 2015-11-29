//
//  YPStatusCell.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/23.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPStatusCell.h"
#import "YPStatus.h"
#import "YPUser.h"
#import "YPStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "YPPhoto.h"
#import "YPStatusToolbar.h"
#import "YPStatusPhotosView.h"
#import "YPIconView.h"
@interface YPStatusCell()

/** 原创微博 */

/**
 *  原创微博整体
 */
@property (nonatomic, weak) UIView *originalView;
/**
 *  头像
 */
@property (nonatomic, weak) YPIconView *iconView;
/**
 *  会员图标
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  配图
 */
@property (nonatomic, weak) YPStatusPhotosView *photosView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *contentLabel;


/** 转发微博 */

/**
 *  转发微博整体
 */
@property (nonatomic, weak) UIView *retweetView; // repost
/**
 *  转发微博正文 + 昵称
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/**
 *  转发配图
 */
@property (nonatomic, weak) YPStatusPhotosView *retweetPhotosView;

/** 工具条 */
@property (nonatomic, weak) YPStatusToolbar *toolbar;

@end

@implementation YPStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    
    YPStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[YPStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

/**
 *  cell的初始化方法,一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件,以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = YPClearColor;
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        [self setupToolbar];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += YPStatusCellMargin;
//    [super setFrame:frame];
//}



/**
 *  初始化工具条
 */
- (void)setupToolbar
{
    YPStatusToolbar *toolbar = [YPStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  初始化转发微博
 */
- (void)setupRetweet
{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = YPRetweetBgColor;
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = YPStatusCellRetweetContentFont;
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    YPStatusPhotosView *retweetPhotosView = [[YPStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginal
{
    /**
     *  原创微博整体
     */
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = YPWhiteColor;
    self.originalView = originalView;
    /**
     *  头像
     *  加V用户
     *  个人认证
     *  企业认证
     */
    YPIconView *iconView = [[YPIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /**
     *  会员图标
     */
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    /**
     *  配图
     */
    YPStatusPhotosView *photosView = [[YPStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    /**
     *  昵称
     */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    nameLabel.font = YPStatusCellNameFont;
    self.nameLabel = nameLabel;
    /**
     *  时间
     */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    timeLabel.font = YPStatusCellTimeFont;
    timeLabel.textColor = YPOrangeColor;
    self.timeLabel = timeLabel;
    /**
     *  来源
     */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    sourceLabel.font = YPStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    /**
     *  正文
     */
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    contentLabel.font = YPStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
}

- (void)setStatusFrame:(YPStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    YPStatus *status = statusFrame.status;
    YPUser *user = status.user;
    
    /**
     *  原创微博整体
     */
    self.originalView.frame = statusFrame.originalViewF;
    /**
     *  头像
     */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /**
     *  会员图标
     */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }

    /**
     *  配图
     */
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }

    /**
     *  昵称
     */
    self.nameLabel.frame = statusFrame.nameLabeLF;
    self.nameLabel.text = user.name;

    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabeLF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabeLF) + YPStatusCellBorderW;
    CGSize timeSize = [NSString sizeWithText:time font:YPStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + YPStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [NSString sizeWithText:status.source font:YPStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;

    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabeLF;
    self.contentLabel.attributedText = status.attributedtext;
    
    
    /** 转发微博 */
    
    if (status.retweeted_status) {
        
        YPStatus *retweeted_status = status.retweeted_status;
        YPUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        /** 转发微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 转发微博正文 */
        self.retweetContentLabel.attributedText = status.retweetedAttributedtext;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 转发微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
#warning TODO 设置图片
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }

    
    /** 工具条 */
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}













@end
