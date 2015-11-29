//
//  YPStatusCell.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/23.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  微博cell

#import <UIKit/UIKit.h>
@class YPStatusFrame;
@interface YPStatusCell : UITableViewCell
/**
 *  微博数据模型
 */
@property (nonatomic, strong) YPStatusFrame *statusFrame;

/**
 *  类方法 - 构造方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
