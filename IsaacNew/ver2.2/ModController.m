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
    self.title=@"MOD合集";
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
    [Common showMessageWithOkButton:@"Mod主要来自贴吧，排序按照发帖时间（可能有些顺序不对），由于即使手机下载下来也还是要到电脑上才能用，所以只提供下载地址，已经标明了作者，如果有出入，请联系我。还有很多MOD没来得及收集，下次会加。很多MOD都没有亲自尝试，介绍的不足之处，请见谅。"];
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
        contentList = [db getModOrSeed:@"1"];
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
            NSString *temp = [NSString stringWithFormat:@"%@\n下载地址:%@\n原帖地址:%@\n作者:%@",bean.content,bean.link,bean.oldlink,bean.author];
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-16;
            CGFloat line = size.width/width;
            line = [Common clcLine:line];
            contentLabel.frame=CGRectMake(8, top, self.view.frame.size.width-16, (line+7)*size.height);
            contentLabel.text = temp;
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
            return top+(line+7)*size.height;
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
