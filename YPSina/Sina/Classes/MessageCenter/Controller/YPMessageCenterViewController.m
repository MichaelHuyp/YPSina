//
//  YPMessageCenterViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/7.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPMessageCenterViewController.h"
#import "YPTest1ViewController.h"
@interface YPMessageCenterViewController ()

@end

@implementation YPMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YPLog(@"%s",__func__);
    
    // style : 这个参数使用来设置背景的，在IOS7之前效果比较明显，IOS7中没有任何效果
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    
    // 这个Item不能点击（就能显示disable下的主题）
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    YPLog(@"%@",self.navigationItem.rightBarButtonItem);
}

- (void)composeMsg
{
    NSLog(@"composeMsg");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test---message---%ld",indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YPTest1ViewController *test1 = [[YPTest1ViewController alloc] init];
    test1.title = @"测试1控制器";
    // 当test1控制器被push的时候,test1所在的tabbarController的tabbar会自动隐藏
    // 当test1控制器被pop的时候,test1所在的tabbarController的tabbar会自动显示
//    test1.hidesBottomBarWhenPushed = YES;
    
    
    // self.navigationCotroller
    // UINavigationController
    // YPNavigationController
    [self.navigationController pushViewController:test1 animated:YES];
}



@end
