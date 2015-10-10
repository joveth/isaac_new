//
//  ModController.m
//  IsaacNew
//
//  Created by Shuwei on 15/10/9.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "ModController.h"

@interface ModController ()

@end

@implementation ModController{
    MBProgressHUD *HUD;
    NSMutableArray *contentList;
    DBHelper *db;
    NSInteger cnt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"加载中...";
    [HUD show:YES];
    db = [DBHelper sharedInstance];
    cnt=0;
    
    if([db openDB]){
        cnt = [db getModSeedCnt];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(cnt<=0){
        if([db openDB]){
            [db initModSeedData:^(BOOL ret) {
                [self load];
            }];
        }
    }
}
-(void)load{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentList count];
}

@end
