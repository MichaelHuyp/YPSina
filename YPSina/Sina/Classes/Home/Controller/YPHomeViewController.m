//
//  YPHomeViewController.m
//  Sina
//
//  Created by 胡云鹏 on 15/8/7.
//  Copyright (c) 2015年 MichaelPPP. All rights reserved.
//  

#import "YPHomeViewController.h"
#import "YPDropdownMenu.h"
#import "YPTitleMenuViewController.h"
#import "YPAccountTool.h"
#import "YPTitleButton.h"
#import "UIImageView+WebCache.h"
#import "YPUser.h"
#import "YPStatus.h"
#import "YPLoadMoreFooter.h"
#import "YPStatusCell.h"
#import "YPStatusFrame.h"

@interface YPHomeViewController () <YPDropdownMenuDelegate>
/**
 *  微博数组（里面放的都是YPStatusFrame模型,一个YPStatusFrame就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation YPHomeViewController

#pragma mark - lazy -
- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

#pragma mark - viewDidLoad -
- (void)viewDidLoad {
    [super viewDidLoad];
//    YPLog(@"%s",__func__);
    
    self.tableView.backgroundColor = YPColor(211, 211, 211);
//    self.tableView.insetT = YPStatusCellMargin;
    
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息（昵称）
    [self setupUserInfo];
    
    // 集成下拉刷新控件
    [self setupDownRefresh];
    
    // 集成上拉刷新控件
    [self setupUpRefresh];
    
    
//    // 获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    // 主线程也会抽时间处理一下timer（不管主线程是否在其他事件）
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    // 通知NSNotification 不可见
    // 本地通知
    // 远程推送通知
    
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    YPAccount *account = [YPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        // 微博的未读数
//        int status = [responseObject[@"status"] intValue];
//        // 设置提醒数字
//        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字（微博未读数）
        
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0 得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YPLog(@"请求失败-%@", error);
    }];
}

/**
 *  集成上拉刷新控件
 */
- (void) setupUpRefresh
{
    YPLoadMoreFooter *footer = [YPLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    // 1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
    // 只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 2.马上进入刷新状态（仅仅是显示刷新状态）
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self loadNewStatus:control];
}

/**
 *  将YPStatus模型转为YPStatusFrame模型
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    // 将YPStatus数组转为YPStatusFrame数组
    NSMutableArray *frames = [NSMutableArray array];
    for (YPStatus *status in statuses) {
        YPStatusFrame *f = [[YPStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

/**
 *  UIRefreshControl进入刷新状态:加载最新的数据
 */
- (void)loadNewStatus:(UIRefreshControl *)control
{
    
#warning YP 加载假数据
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSDictionary *responseObject = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeStatus" ofType:@"plist"]];
//        // 将 "微博字典"数组 转为 "微博模型"数组
//        NSArray *newStatuses = [YPStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        // 将 HWStatus数组 转为 HWStatusFrame数组
//        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
//        
//        // 将最新的微博数据，添加到总数组的最前面
//        NSRange range = NSMakeRange(0, newFrames.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:newFrames atIndexes:set];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 结束刷新
//        [control endRefreshing];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCount:newStatuses.count];
//    });
//    
//    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    YPAccount *account = [YPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    YPStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        YPLog(@"%@",responseObject);
        
        // 将"微博字典"数组转为"微博模型"数组
        NSArray *newStatuses = [YPStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

#warning YP 提取假数据位置
        
        // 将YPStatus数组转为YPStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [control endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YPLog(@"请求失败-%@",error);
        // 结束刷新
        [control endRefreshing];
    }];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    YPAccount *account = [YPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最旧的微博，ID最小的微博）
    YPStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博,默认为0
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 将"微博字典"数组转为"微博模型"数组
        NSArray *newStatuses = [YPStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将YPStatus数组转为YPStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将更多地微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YPLog(@"请求失败-%@",error);
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}


/**
 *  显示最新微博的数量
 */
- (void)showNewStatusCount:(NSInteger)count
{
    
    // 刷新成功（清空图标数字）
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = YPScreenW;
    label.height = 35;
    
    // 2.设置其他属性
    if (count == 0) { // 没有最新微博
        label.text = @"没有新的微博数据";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 3.添加
    label.y = 64- label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    // 先利用0.5s的时间让label往下移动一段距离
    CGFloat duration = 0.5; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟0.5s后，再利用0.5s的时间让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 0.5; // 延迟0.5s
        // UIViewAnimationOptionCurveLinear 匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            // 清空transform
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}

/**
 *  获得用户信息（昵称）
 */
- (void)setupUserInfo
{
    // https://api.weibo.com/2/users/show.json
    // access_token	false string 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
   //  uid false int64 需要查询的用户ID。
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.拼接请求参数
    YPAccount *account = [YPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        YPLog(@"请求成功-%@",responseObject);
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
        YPUser *user = [YPUser objectWithKeyValues:responseObject];
        
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [YPAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YPLog(@"请求失败-%@",error);
    }];
}

/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(friendsearch) andImage:@"navigationbar_friendsearch" andHighImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(pop) andImage:@"navigationbar_pop" andHighImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    YPTitleButton *titleButton = [YPTitleButton titleButton];
    
    // 设置图片和文字
    NSString *name = [YPAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    // 1.创建下拉菜单
    YPDropdownMenu *menu = [YPDropdownMenu menu];
    menu.delegate = self;
    // 2.设置内容
    YPTitleMenuViewController *vc = [[YPTitleMenuViewController alloc] init];
    vc.view.height = 200;
    vc.view.width = 200;
    
    menu.contentController = vc;
    
    // 3.显示
    [menu showFrom:titleButton];
}


- (void)friendsearch
{
    NSLog(@"friendsearch");
}

- (void)pop
{
    NSLog(@"pop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YPDropdownMenuDelegate -
/**
 *  下拉菜单被销毁了
 */
- (void)dropdownMenuDidDismiss:(YPDropdownMenu *)menu
{
    UIButton *titlerBtn = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
//    [titlerBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titlerBtn.selected = NO;
}
/**
 *  下拉菜单显示
 */
- (void)dropdownMenuDidShow:(YPDropdownMenu *)menu
{
    UIButton *titlerBtn = (UIButton *)self.navigationItem.titleView;
    // 让箭头向上
//    [titlerBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titlerBtn.selected = YES;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YPStatusCell *cell = [YPStatusCell cellWithTableView:tableView];
    
    
    // 给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.offsetY;
    
    // 当最后一个cell完全显示在眼前时,contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentH + scrollView.insetB - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY){ //最后一个cell完全进入视野范围
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        // 加载更多地微博数据
        [self loadMoreStatus];
    }
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YPStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}




































@end
