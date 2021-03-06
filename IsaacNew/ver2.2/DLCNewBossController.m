//
//  DLCNewBossController.m
//  IsaacNew
//
//  Created by Shuwei on 15/11/6.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "DLCNewBossController.h"

@interface DLCNewBossController ()

@end

@implementation DLCNewBossController{
    MBProgressHUD *hud;
    NSMutableArray *list;
    DBHelper *db;
    CGFloat width;
    BOOL flag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    db=[DBHelper sharedInstance];
    list = [[NSMutableArray alloc] init];
    width = [UIScreen mainScreen].applicationFrame.size.width-55;
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"加载中...";
    self.tableView.tableFooterView=[[UIView alloc] init];
    [hud show:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self load];
}
-(void)load{
    if([db openDB]){
        list = [db getBossByKey:@"dlc_b"];
        [self.tableView reloadData];
    }
    [hud hide:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell    *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:1];
    UIImageView *image=(UIImageView*)[cell viewWithTag:2];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:3];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 4, width, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=1;
        [cell addSubview:nameLabel];
    }
    if(image==nil){
        image = [[UIImageView alloc]init];
        image.tag=2;
        [cell addSubview:image];
    }
    if(contentLabel==nil){
        contentLabel = [[UILabel alloc] init];
        contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        contentLabel.numberOfLines=0;
        contentLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        contentLabel.tag=3;
        [cell addSubview:contentLabel];
    }
    BossBean *bean = [list objectAtIndex:indexPath.row];
    if(flag){
        [nameLabel removeFromSuperview];
        [image removeFromSuperview];
        [contentLabel removeFromSuperview];
        cell.imageView.image=[UIImage imageNamed:bean.image];
        cell.textLabel.text=[NSString stringWithFormat:@"%@(%@)",bean.name,bean.enName];
    }else{
        
        if(bean){
            nameLabel.text = [NSString stringWithFormat:@"%@(%@)",bean.name,bean.enName];
            if(![Common isEmptyString:bean.image]){
                image.image = [UIImage imageNamed:bean.image];
            }
            if(![Common isEmptyString:bean.content]){
                CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
                CGFloat line = size.width/width;
                line = [Common clcLine:line];
                contentLabel.frame=CGRectMake(50, 30, width, size.height*line);
                contentLabel.text = bean.content;
                image.frame = CGRectMake(4, (size.height*line-10)/2, 40, 40);
            }else{
                image.frame = CGRectMake(8, 2, 40, 40);
            }
            
        }
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(flag){
        return 44;
    }
    BossBean *bean = [list objectAtIndex:indexPath.row];
    if(bean){
        if(![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat line = size.width/width;
            line = [Common clcLine:line];
            return size.height*line+40;
        }
    }
    
    return 44;
}


@end
