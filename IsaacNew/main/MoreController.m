//
//  MoreController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/14.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "MoreController.h"
#import "Common.h"
#import "MoreOther.h"
#import "ShareData.h"
#import "AboutMeActivity.h"

@interface MoreController ()

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView=[[UIView alloc] init];
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.tableView.backgroundColor=[Common colorWithHexString:@"#e0e0e0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 3;
    }else{
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *myHeader = [[UIView alloc] init];
    UILabel *myLabel = [[UILabel alloc] init];
    [myLabel setFrame:CGRectMake(8, 0, 200, 10)];
    [myLabel setTag:101];
    [myLabel setAlpha:0.5];
    [myLabel setFont: [UIFont fontWithName:@"Arial" size:14]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myHeader setBackgroundColor:[Common colorWithHexString:@"#e0e0e0"]];
    [myLabel setText:[NSString stringWithFormat:@" "]];
    [myHeader addSubview:myLabel];
    return myHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = [UIColor greenColor];
    }
    if(indexPath.section==0&&indexPath.row==0){
        cell.textLabel.text=@"Boss Rush";
    }else if(indexPath.section==0&&indexPath.row==1){
        cell.textLabel.text=@"捐款机&献血机";
    }else if(indexPath.section==0&&indexPath.row==2){
        cell.textLabel.text=@"猫套&苍蝇套";
    }
    else {
        cell.textLabel.text=@"更新、计划、那人";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    if(indexPath.section==0){
        MoreOther *show =[[MoreOther alloc] init];
        [ShareData shareInstance].type=[NSString stringWithFormat:@"%ld",(indexPath.row+1)];
        [self.navigationController pushViewController:show animated:YES];
    }else{
        WebController *show = [[WebController alloc] init];
        [ShareData shareInstance].urltype=@"http://joveth.github.io/isaac_new/index.html";
        show.title=@"闲情记事";
        [self.navigationController pushViewController:show animated:YES];
//        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        AboutMeActivity *show = (AboutMeActivity*)[storyboard instantiateViewControllerWithIdentifier:@"AboutMe"];
//        [self.navigationController pushViewController:show animated:YES];
    }
}

@end
