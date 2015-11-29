//
//  YPTabBarViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/7.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPTabBarViewController.h"
#import "YPHomeViewController.h"
#import "YPMessageCenterViewController.h"
#import "YPDiscoverViewController.h"
#import "YPProfileViewController.h"
#import "YPNavigationViewController.h"
#import "YPTabBar.h"
#import "YPComposeViewController.h"
@interface YPTabBarViewController () <YPTabBarDelegate>

@end

@implementation YPTabBarViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化子控制器
    
    // 创建首页控制器并添加首页控制器为子控制器1
    YPHomeViewController *home = [[YPHomeViewController alloc] init];
    [self addChildVc:home andTitle:@"首页" andImage:@"tabbar_home" andSelectedImage:@"tabbar_home_selected"];
    
    // 创建消息中心控制器并添加消息中心控制器为子控制器2
    YPMessageCenterViewController *messageCenter = [[YPMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter andTitle:@"消息" andImage:@"tabbar_message_center" andSelectedImage:@"tabbar_message_center_selected"];
    
    // 创建发现控制器并添加发现控制器为子控制器3
    YPDiscoverViewController *discover = [[YPDiscoverViewController alloc] init];
    [self addChildVc:discover andTitle:@"发现" andImage:@"tabbar_discover" andSelectedImage:@"tabbar_discover_selected"];
    
    // 创建我控制器并添加我控制器为子控制器4
    YPProfileViewController *profile = [[YPProfileViewController alloc] init];
    [self addChildVc:profile andTitle:@"我" andImage:@"tabbar_profile" andSelectedImage:@"tabbar_profile_selected"];
    
    // 2.更换系统自带的tabbar
//    self.tabBar = [[YPTabBar alloc] init];
    // KVC方式更换tabbar
    YPTabBar *tabBar = [[YPTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
//    [tabBar tabBarDidClickPlusButtonBlock:^(YPTabBar *tabbar) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.view.backgroundColor = [UIColor redColor];
//        [self presentViewController:vc animated:YES completion:nil];
//    }];
    /**
     *  [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.taBbar = tabBar
     *  [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后,tabbar的delegate就是当前的YPTabBarViewController
     *  如果tabBar设置完delegate后,再执行这行代码修改delegate后,就会报错
     *  说明,不用再设置 tabBar.delegate = self;
     *  如果再次修改tabBar的delegate属性就会报下面这个错误
     *  错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     *  错误意思：不允许修改TabBar的delegate属性（这个TabBar是被TabBarViewController所管理的）
     */
//    tabBar.delegate = self;
    

}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    int count = (int)self.tabBar.subviews.count;
//    
//    for (int i = 0; i < count; i++) {
//        UIView *child = self.tabBar.subviews[i];
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([child isKindOfClass:class]) {
//            child.width = self.tabBar.width / count;
//        }
//    }
//}


/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
//    childVc.tabBarItem.title = title;         // 设置tabbar的文字
//    childVc.navigationItem.title = title;     // 设置navigatinBar的文字
    childVc.title = title;  // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式 - NSForegroundColorAttributeName 文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = YPColor(123,123,123);
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
//    childVc.view.backgroundColor = YPRandomColor;
    
    // 先给外面传进来的小控制器包装一个自定义的导航控制器
    YPNavigationViewController *nav = [[YPNavigationViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark - YPTabBarDelegate -
- (void)tabBarDidClickPlusButton:(YPTabBar *)tabbar
{
//    YPComposeViewController *compose = [[YPComposeViewController alloc] init];
    
    YPNavigationViewController *nav = [[YPNavigationViewController alloc] initWithRootViewController:[[YPComposeViewController alloc] init]];
    
    [self presentViewController:nav animated:YES completion:nil];
}













@end
