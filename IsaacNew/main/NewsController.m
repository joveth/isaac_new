//
//  NewsController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/11.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "NewsController.h"
#import "WebService.h"
#import "MBProgressHUD.h"
#import "Topic.h"
#import "MJRefresh.h"
#import "ShareData.h"
#import "Common.h"
#import "WebController.h"

@interface NewsController ()

@end

@implementation NewsController{
    MBProgressHUD *HUD;
    NSMutableArray *list;
    NSInteger page;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=[ShareData shareInstance].title;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    //HUD.labelText = @"加载中...";
    //[HUD show:YES];
    
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    list = [[NSMutableArray alloc] init];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.header.automaticallyChangeAlpha = YES;
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    // 上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.header beginRefreshing];
}

-(void)refreshData{
    page=1;
    [WebService getAllTopicsWithPage:page andTag:[ShareData shareInstance].urltype andSuc:^(NSArray *_ret) {
        NSLog(@"count=%ld",[_ret count]);
        //[HUD hide:YES];
        if(_ret&&[_ret count]>0){
            [list removeAllObjects ];
            [list addObjectsFromArray:_ret];
            [self.tableView reloadData];
        }else{
            [Common showMessageWithOkButton:@"该模块还没有数据呢！"];
        }
        [self.tableView.header endRefreshing];
    } andErr:^(NSInteger code) {
        NSLog(@"code=%ld",code);
        //[HUD hide:YES];
        [self.tableView.header endRefreshing];
    }];
}
-(void)loadMoreData{
    page++;
    [WebService getAllTopicsWithPage:page andTag: [ShareData shareInstance].urltype andSuc:^(NSArray *_ret)  {
        NSLog(@"count=%ld",[_ret count]);
        if(_ret&&[_ret count]>0){
            [list addObjectsFromArray:_ret];
            [self.tableView reloadData];
        }else{
            page --;
        }
        [self.tableView.footer endRefreshing];
    } andErr:^(NSInteger code) {
        NSLog(@"code=%ld",code);
        //[HUD hide:YES];
        [self.tableView.footer endRefreshing];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = [UIColor greenColor];
    }
    Topic *topic = [list objectAtIndex:indexPath.row];
    if(topic){
        cell.textLabel.text = topic.Title;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Topic *topic = [list objectAtIndex:indexPath.row];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    if(topic){
        WebController *show = [[WebController alloc] init];
        [ShareData shareInstance].urltype=topic.Id;
        [ShareData shareInstance].title=topic.Title;
        [self.navigationController pushViewController:show animated:YES];
    }
}

@end
