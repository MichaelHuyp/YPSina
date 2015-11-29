//
//  YPComposeViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/27.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPComposeViewController.h"
#import "YPAccountTool.h"
#import "YPPlaceholderTextView.h"
@interface YPComposeViewController ()

@property (nonatomic, weak) YPPlaceholderTextView *textView;

@end

@implementation YPComposeViewController
#pragma mark - 系统方法 -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = YPWhiteColor;
    
    // 默认是YES,当scrollView遇到UINavigationBar、UITabBar等控件时,默认会设置scrollView的contentInset
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
}
- (void)dealloc
{
    [YPNotificationCenter removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
#pragma mark - 初始化方法 -
/**
 *  添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中,textView的contentInset.top会默认为64
    
    YPPlaceholderTextView *textView = [[YPPlaceholderTextView alloc] init];
    [self.view addSubview:textView];
    textView.frame = self.view.bounds;
    textView.font = YPFont_15;
    textView.placeholder = @"分享你的新鲜事...";
    self.textView = textView;
    
    // 监听通知
    [YPNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}
/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    // 获取用户名
    NSString *name = [YPAccountTool account].name;
    // 定义前缀
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        // 自动换行
        titleView.numberOfLines = 0;
        
        // 拼接titleView文字
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        // 获取用户名范围
        NSRange nameRange = [str rangeOfString:name];
        // 获取前缀范围
        NSRange prefixRange = [str rangeOfString:prefix];
        
        // 创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:prefixRange];
        [attrStr addAttribute:NSForegroundColorAttributeName value:YPLightGrayColor range:nameRange];
        [attrStr addAttribute:NSFontAttributeName value:YPFont_12 range:nameRange];
        
        titleView.attributedText = attrStr;
        
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
    
    

}


#pragma mark - 监听方法
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    /**
     *  URL:https://api.weibo.com/2/statuses/update.json
     *  参数:
     *  status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     *  pic	false binary 要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
     *  access_token true string
     */
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [YPAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:[params copy] success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发布失败"];
        YPLog(@"请求失败 - %@",error);
    }];
    
    // 4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

@end

































