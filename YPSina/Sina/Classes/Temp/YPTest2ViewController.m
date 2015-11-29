//
//  YPTest2ViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/8.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPTest2ViewController.h"
#import "YPTest3ViewController.h"
@interface YPTest2ViewController ()

@end

@implementation YPTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    YPTest3ViewController *test3 = [[YPTest3ViewController alloc] init];
    test3.title = @"测试3控制器";
    [self.navigationController pushViewController:test3 animated:YES];
}

@end
