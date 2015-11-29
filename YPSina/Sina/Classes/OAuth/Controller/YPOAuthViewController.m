//
//  YPOAuthViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/17.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPOAuthViewController.h"
#import "YPAccountTool.h"

@interface YPOAuthViewController () <UIWebViewDelegate>

@end

@implementation YPOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.用webView加载登录页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /**
     *  请求参数：
     *  client_id	true	string	申请应用时分配的AppKey。
     *  redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1576468831&redirect_uri=https://api.weibo.com/oauth2/default.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate -
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在拼命加载中...^_^"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    YPLog(@"shouldStartLoadWithRequest--%@",request.URL.absoluteString);
    
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length !=0) { // 是回调地址
        // 截取code=后面的参数值
        int fromIndex = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}
/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  OAuth2的access_token接口
 *  URL
 *  https://api.weibo.com/oauth2/access_token
 *  HTTP请求方式
 *  POST
 *  请求参数
 *                   必选   类型及范围      说明
 *  client_id        true	string	申请应用时分配的AppKey。
 *  client_secret	 true	string	申请应用时分配的AppSecret。
 *  grant_type	     true	string	请求的类型，填写authorization_code
 *
 *  grant_type为authorization_code时
 *                  必选  	类型及范围	  说明
 *  code	        true    string      调用authorize获得的code值。
 *  redirect_uri	true	string      回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1576468831";
    params[@"client_secret"] = @"22316f7a15b1733d8761c33f8876ba2b";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"https://api.weibo.com/oauth2/default.html";
    
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:[params copy] success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        YPAccount *account = [YPAccount accountWithDict:responseObject];
        
        // 存储账号信息
        [YPAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        // UIWindow的分类、WindowTool、UIViewController的分类、UIViewControllerTool
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        YPLog(@"请求失败 - %@",error);
    }];
}





















@end
