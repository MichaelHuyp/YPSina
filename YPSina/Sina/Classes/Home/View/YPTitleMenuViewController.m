//
//  YPTitleMenuViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/11.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//

#import "YPTitleMenuViewController.h"

@interface YPTitleMenuViewController ()

@end

@implementation YPTitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"密友";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"全部";
    }
    
    return cell;
}



@end
