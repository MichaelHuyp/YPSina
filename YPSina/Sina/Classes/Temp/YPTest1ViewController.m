//
//  YPTest1ViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/8.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPTest1ViewController.h"
#import "YPTest2ViewController.h"
@interface YPTest1ViewController ()

@end

@implementation YPTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    YPTest2ViewController *test2 = [[YPTest2ViewController alloc] init];
    test2.title = @"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
