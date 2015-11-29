//
//  YPStatus.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/20.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPStatus.h"
#import "YPPhoto.h"
#import "RegexKitLite.h"
#import "YPUser.h"
#import "YPTextPart.h"
@implementation YPStatus

/**
 *  MJExtension 说明微博模型的数组属性pic_urls内存的是YPPhoto模型
 */
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [YPPhoto class]};
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    self.attributedtext = [self attributedTextWithText:text];
    
}

- (void)setRetweeted_status:(YPStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name,retweeted_status.text];
    
    self.retweetedAttributedtext = [self attributedTextWithText:retweetContent];
}

/**
 *  普通文字 -> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text
{
    // 利用text生成attributedText
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emojiPattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5\\-+_+]+";
    
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    
    // url链接规则
    NSString *urlPattern = @"(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?";
    
    // | 匹配多个条件，相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emojiPattern,atPattern,topicPattern,urlPattern];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return ;
        YPTextPart *part = [[YPTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return ;
        YPTextPart *part = [[YPTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 排序
    [parts sortUsingComparator:^NSComparisonResult(YPTextPart *part1, YPTextPart *part2) {
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
    // 按顺序拼接每一段文字
    for (YPTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            // 拼接表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = [UIImage imageNamed:@"d_aini"];
            attch.bounds = CGRectMake(0, -3, 15, 15);
            substr = [NSAttributedString attributedStringWithAttachment:attch];
        } else if (part.special) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体，保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attributedText.length)];
    
    YPLog(@"%@",text);
    
    return attributedText;
}


/**
 *  1.今年
 *      1> 今天
 *          * 1分钟内发的 : 刚刚
 *          * 1分钟~59分钟内 : xx分钟前
 *          * 大于60分钟 : xx小时前
 *      2> 昨天
 *          * 昨天 xx:xx
 *      3> 其他
 *          * xx-xx xx:xx
 *  2.非今年
 *      1> xxxx-xx-xx xx:xx
 */
- (NSString *)created_at
{
    // created_at = Tue Aug 25 20:07:00 +0800 2015
    // dateFormat = EEE MMM dd HH:mm:ss Z yyyy
    // NSString --> NSDate
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制
    // m:分钟
    // s:秒
    // Z:时区
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

/**
 *  <a href="http://app.weibo.com/t/feed/3mEge0" rel="nofollow">秒拍客户端</a>
 */
- (void)setSource:(NSString *)source
{
    // 正则表达式 NSRegularExpression
    
    // 截串 NSString
    
    if (source.length) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        
        _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
    }
}

@end
