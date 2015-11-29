//
//  YPNewfeatureViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/15.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPNewfeatureViewController.h"
#import "YPTabBarViewController.h"
#define YPNewfeatureCount 4

@interface YPNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation YPNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.创建一个scrollView:显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < YPNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        // 显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == YPNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
#warning 默认情况下，scrollView一旦创建出来，它里面就可能就存在一些子控件了
#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
    
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动,那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(YPNewfeatureCount * scrollW, 0);

    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 4.添加pageControl : 分页,展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.numberOfPages = YPNewfeatureCount;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.94f green:0.38f blue:0.19f alpha:1.00f];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    /**
     *  UIPageControl就算没有chicun,里面的内容还是照常显示的
     *  pageControl.width = 100;
     *  pageControl.height = 50;
     *  pageControl.userInteractionEnabled = NO;
     */
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 传统做法计算页码
//    int page = (scrollView.contentOffset.x + 0.5 * scrollView.width) / scrollView.width;
//    self.pageControl.currentPage = page;
    
    // 四舍五入计算页码
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 1.分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
//    EdgeInsets:自切
//    shareBtn.titleEdgeInsets:只影响按钮内部的imageView
//    shareBtn.imageEdgeInsets:只影响按钮内部的titleLabel
//    shareBtn.contentEdgeInsets:会影响按钮内部的所有内容（里面的imageView和titleLabel）
    
    
    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)shareClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    // 切换到YPTabBarController
    /**
     *  切换控制器的手段
     *  1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     *  2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A 不建议采取，新特性控制器不会被销毁
     *  3.切换window的rootViewController
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[YPTabBarViewController alloc] init];
}

- (void)dealloc
{
    YPLog(@"dealloc");
}













@end
