//
//  YPTabBar.h
//  Sina
//
//  Created by 胡云鹏 on 15/8/13.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPTabBar;

// Block
typedef void(^tabBarDidClickPlusButtonBlock)(YPTabBar *tabbar);

#warning 因为YPTabBar继承自UITabBar,所以成为YPTabBar的代理,也必须实现UITabBar的代理协议
@protocol YPTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(YPTabBar *)tabbar;

@end

@interface YPTabBar : UITabBar
@property (nonatomic, assign) id<YPTabBarDelegate> delegate;
@property (nonatomic, copy) tabBarDidClickPlusButtonBlock didClickBlock;
- (void)tabBarDidClickPlusButtonBlock:(tabBarDidClickPlusButtonBlock)didClickBlock;
@end
