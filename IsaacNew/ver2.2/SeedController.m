//
//  SeedController.m
//  IsaacNew
//
//  Created by Shuwei on 15/10/10.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "SeedController.h"

@interface SeedController ()

@end

@implementation SeedController{
    MBProgressHUD *HUD;
    NSMutableArray *contentList;
    DBHelper *db;
    NSInteger cnt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Seed种子";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"?" style:UIBarButtonItemStyleBordered target:self action:@selector(showHint:)];
    rightItem.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =rightItem;
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
-(IBAction)showHint:(id)sender{
    [Common showMessageWithOkButton:@"Seed主要来自贴吧，由于可能有版本不一致的原因导致与种子效果不一样，这里说声抱歉，因为我也没有一个一个去试（惭愧~~）。如果觉得有问题，请联系我。"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(cnt<=0){
        if([db openDB]){
            [db initModSeedData:^(BOOL ret) {
                [self load];
            }];
        }
    }else{
        [self load];
    }
}
-(void)load{
    if([db openDB]){
        contentList = [db getModOrSeed:@"2"];
        [self.tableView reloadData];
    }
    [HUD hide:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell    *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:1];
    UIImageView *image=(UIImageView*)[cell viewWithTag:2];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:3];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-16, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=1;
        [cell addSubview:nameLabel];
    }
    if(image==nil){
        image = [[UIImageView alloc]initWithFrame:CGRectMake(8, 38, self.view.frame.size.width-16, 100)];
        image.tag=2;
        [cell addSubview:image];
    }
    if(contentLabel==nil){
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 38, self.view.frame.size.width-16, 100)];
        contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        contentLabel.numberOfLines=0;
        contentLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        contentLabel.tag=3;
        [cell addSubview:contentLabel];
    }
    
    ModSeedBean *bean = [contentList objectAtIndex:indexPath.row];
    if(bean){
        nameLabel.text = bean.name;
        CGFloat top=0;
        if(![Common isEmptyString:bean.image]){
            image.image = [UIImage imageNamed:bean.image];
            image.hidden=NO;
            top = 146;
        }else{
            image.hidden=YES;
            top = 38;
        }
        if(![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-16;
            CGFloat line = size.width/width;
            line = [Common clcLine:line];
            contentLabel.frame=CGRectMake(8, top, self.view.frame.size.width-16, (line+1)*size.height);
            contentLabel.text = bean.content;
            contentLabel.textAlignment=NSTextAlignmentJustified;
        }
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModSeedBean *bean = [contentList objectAtIndex:indexPath.row];
    if(bean){
        CGFloat top=0;
        if(![Common isEmptyString:bean.image]){
            top = 146;
        }else{
            top = 38;
        }
        if(![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-16;
            CGFloat line = size.width/width;
            line = [Common clcLine:line];
            return top+(line+1)*size.height;
        }
        return top;
    }
    return 44;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentList count];
}

@end
