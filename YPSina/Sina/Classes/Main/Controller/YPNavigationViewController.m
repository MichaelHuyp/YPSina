//
//  YPNavigationViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/8.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPNavigationViewController.h"
@interface YPNavigationViewController ()

@end

@implementation YPNavigationViewController

/**
 *  这个方法在类初次创建会调用一次
 */
+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key : NSxxxxAttributeName
    // NSFontAttributeName - 字体
#warning TODO 字体BUG
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // 橙色字体
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 15号字体
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    // 设置可用的UIBarButtonItem样式
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];


    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    // 灰色字体
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    // 9号字体大小
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    // 设置不可用的UIBarButtonItem样式
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  重写这个方法的目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这是push进来的控制器，不是第一个控制器（不是根控制器）
        /**
         *  自动显示和隐藏tabbar
         */
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设施控制器导航条上的左Item样式
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(back) andImage:@"navigationbar_back" andHighImage:@"navigationbar_back_highlighted"];
        // 设施控制器导航条上的右Item样式
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(more) andImage:@"navigationbar_more" andHighImage:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}


- (void)more
{
#warning 这里要用self,不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController是nil的
    // 回到根控制器
    [self popToRootViewControllerAnimated:YES];
}

- (void)back
{
    // 回到上一级控制器
    [self popViewControllerAnimated:YES];
}


@end
