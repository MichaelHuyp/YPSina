//
//  YPSearchBar.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/10.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPSearchBar.h"

@implementation YPSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 设置左边的放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

/**
 *  创建一个SearchBar
 */
+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
