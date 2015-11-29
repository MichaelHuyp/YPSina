//
//  YPStatusFrame.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/23.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPStatusFrame.h"
#import "YPStatus.h"
#import "YPUser.h"
#import "YPStatusPhotosView.h"


@implementation YPStatusFrame

- (void)setStatus:(YPStatus *)status
{
    _status = status;
    
    YPUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = YPStatusCellBorderW;
    CGFloat iconY = YPStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + YPStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [NSString sizeWithText:user.name font:YPStatusCellNameFont];
    self.nameLabeLF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabeLF) + YPStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipH, vipW);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabeLF) + YPStatusCellBorderW;
    CGSize timeSize = [NSString sizeWithText:status.created_at font:YPStatusCellTimeFont];
    self.timeLabeLF = (CGRect){{timeX,timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabeLF) + YPStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [NSString sizeWithText:status.source font:YPStatusCellSourceFont];
    self.sourceLabeLF = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabeLF)) + YPStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
//    CGSize contentSize = [NSString sizeWithText:status.text font:YPStatusCellContentFont maxW:maxW];
    CGSize contentSize = [status.attributedtext boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.contentLabeLF = (CGRect){{contentX,contentY},contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabeLF) + YPStatusCellBorderW;
        CGSize photosSize = [YPStatusPhotosView sizeWithCount:(int)status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX, photosY},photosSize};
        originalH = CGRectGetMaxY(self.photosViewF) + YPStatusCellBorderW;
    } else {
        originalH = CGRectGetMaxY(self.contentLabeLF) + YPStatusCellBorderW;
    }

    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = YPStatusCellMargin;
    CGFloat originalW = cellW;
    
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    CGFloat toolbarY = 0;
    /** 转发微博 */
    
    if (status.retweeted_status) {
        YPStatus *retweeted_status = status.retweeted_status;
        YPUser *retweeted_status_user = retweeted_status.user;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        /** 转发微博正文 */
        CGFloat retweetContentX = YPStatusCellBorderW;
        CGFloat retweetContentY = YPStatusCellBorderW;
//        CGSize retweetContentSize = [NSString sizeWithText:retweetContent font:YPStatusCellRetweetContentFont maxW:maxW];
        CGSize retweetContentSize = [retweeted_status.attributedtext boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        /** 转发微博配图 */
        CGFloat retweetViewH = 0;
        
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + YPStatusCellBorderW;
            CGSize retweetPhotosSize = [YPStatusPhotosView sizeWithCount:(int)retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX, retweetPhotosY},retweetPhotosSize};
            retweetViewH = CGRectGetMaxY(self.retweetPhotosViewF) + YPStatusCellBorderW;
        } else { // 转发微博没有配图
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelF) + YPStatusCellBorderW;
        }
        
        /** 转发微博整体 */
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = cellW;
        
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /** cell高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
    
}

@end
