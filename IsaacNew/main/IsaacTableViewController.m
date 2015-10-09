//
//  IsaacTableViewController.m
//  Isaac
//
//  Created by Shuwei on 15/9/8.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "IsaacTableViewController.h"
#import "WebService.h"
#import "MBProgressHUD.h"
#import "DBHelper.h"
#import "IsaacBean.h"
#import "Common.h"

@interface IsaacTableViewController ()

@end

@implementation IsaacTableViewController{
    MBProgressHUD *HUD;
    NSMutableArray *contentList;
    DBHelper *db;
    UISearchBar *searchHeader;
    UIButton *rightBtn;
    UIButton *leftBtn;
    NSArray *titleArr ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"以撒图鉴";
    contentList  =[[NSMutableArray alloc] init];
    db = [DBHelper sharedInstance];
    titleArr= [[NSArray alloc] initWithObjects:@"全部",@"主动", @"被动",@"饰品",@"塔牌",@"符文",@"胶囊",@"人物",@"成就", nil];
    leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-78, 24, 70, 36)];
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    leftBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [leftBtn setTitle:@"全部" forState:UIControlStateNormal];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"加载中...";
    [HUD show:YES];
    [leftBtn addTarget:self  action:@selector(showMenu) forControlEvents:UIControlEventTouchDown];
    [self.navigationController.view addSubview: leftBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [leftBtn removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell    *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:1];
    UIImageView *image=(UIImageView*)[cell viewWithTag:2];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:3];
    UILabel *otherLabel=(UILabel*)[cell viewWithTag:4];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, self.view.frame.size.width-55, 22)];
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
    if(otherLabel==nil){
        otherLabel = [[UILabel alloc] init];
        otherLabel.lineBreakMode=NSLineBreakByWordWrapping;
        otherLabel.numberOfLines=0;
        otherLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        otherLabel.tag=4;
        [cell addSubview:otherLabel];
    }
    
    IsaacBean *bean = [contentList objectAtIndex:indexPath.row];
    if(bean){
        nameLabel.text = [NSString stringWithFormat:@"%@(%@)",bean.name,bean.enName];
        if(![Common isEmptyString:bean.image]){
            image.image = [UIImage imageNamed:bean.image];
            image.frame = CGRectMake(8, cell.frame.size.height-18, 30, 30);
        }
        if(![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-55;
            CGFloat line = size.width/width;
            if(line<1){
                line=1;
            }else{
                NSString *th = [NSString stringWithFormat:@"%0.0f",line];
                NSInteger t = th.integerValue;
                if(line-t>0){
                    line  = t+1;
                }else{
                    line = t;
                }
            }
            //            NSString *temp = [NSString stringWithFormat:@"%0.0f",lines];
            contentLabel.frame=CGRectMake(50, 30, self.view.frame.size.width-55, size.height*line+30);
            contentLabel.text = bean.content;
            NSString *other = @"解锁方式：无说明";
            if(![Common isEmptyString:bean.unlock]){
                other = bean.unlock;
            }
            CGFloat top = size.height*line+60;
            size =[other sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            otherLabel.text =other;
            line =size.width/width;
            if(line<1){
                line=1;
            }else{
                NSString *th = [NSString stringWithFormat:@"%0.0f",line];
                NSInteger t = th.integerValue;
                if(line-t>0){
                    line  = t+1;
                }else{
                    line = t;
                }
            }
            otherLabel.frame=CGRectMake(50, top, self.view.frame.size.width-55, size.height*line+10);
            
        }else{
            image.frame = CGRectMake(8, 8, 30, 30);
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-55;
            
            NSString *other = @"解锁方式：无说明";
            if(![Common isEmptyString:bean.unlock]){
                other = bean.unlock;
            }
            
            CGSize size =[other sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            otherLabel.text =other;
            CGFloat line =size.width/width;
            if(line<1){
                line=1;
            }else{
                NSString *th = [NSString stringWithFormat:@"%0.0f",line];
                NSInteger t = th.integerValue;
                if(line-t>0){
                    line  = t+1;
                }else{
                    line = t;
                }
            }
            otherLabel.frame=CGRectMake(50, 30, self.view.frame.size.width-55, size.height*line+10);
        }
        
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    IsaacBean *bean = [contentList objectAtIndex:indexPath.row];
    if(bean){
        
        if(![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-55;
            CGFloat line = size.width/width;
            if(line<1){
                line=1;
            }else{
                NSString *th = [NSString stringWithFormat:@"%0.0f",line];
                NSInteger t = th.integerValue;
                if(line-t>0){
                    line  = t+1;
                }else{
                    line = t;
                }
            }
            CGFloat height =size.height*line;
            NSString *other = @"解锁方式：无说明";
            if(![Common isEmptyString:bean.unlock]){
                other = bean.unlock;
            }
            size =[other sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            line =size.width/width;
            if(line<1){
                line=1;
            }else{
                NSString *th = [NSString stringWithFormat:@"%0.0f",line];
                NSInteger t = th.integerValue;
                if(line-t>0){
                    line  = t+1;
                }else{
                    line = t;
                }
            }
            //NSString *temp = [NSString stringWithFormat:@"%0.0f",lines];
            return height+size.height*line+80;
        }else{
            
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-55;
            NSString *other = @"解锁方式：无说明";
            if(![Common isEmptyString:bean.unlock]){
                other = bean.unlock;
            }
            CGSize size =[other sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:12.0f] forKey:NSFontAttributeName]];
            CGFloat line =size.width/width;
            if(line<1){
                line=1;
            }else{
                NSString *th = [NSString stringWithFormat:@"%0.0f",line];
                NSInteger t = th.integerValue;
                if(line-t>0){
                    line  = t+1;
                }else{
                    line = t;
                }
            }
            return size.height*line+40;
        }
        
    }
    return 44;
}
-(void)loadData{
    [db openDB];
    contentList = [db getIsaacs:@"1"];
    [self.tableView reloadData];
    [HUD hide:YES];
}

-(void)showMenu{
    [searchHeader resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部",@"主动", @"被动",@"饰品",@"塔牌",@"符文",@"胶囊",@"人物",@"成就",nil];
    [sheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    [sheet showInView:[self.view window]];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [HUD show:YES];
        contentList = [db getIsaacs:@"1"];
        [leftBtn setTitle:@"全部" forState:UIControlStateNormal];
        [self.tableView reloadData];
        [HUD hide:YES];
    }else if(buttonIndex!=9) {
        [HUD show:YES];
        contentList=[db getIsaacsByType:[NSString stringWithFormat:@"%ld",(long)buttonIndex]];
        [leftBtn setTitle:[titleArr objectAtIndex:buttonIndex] forState:UIControlStateNormal];
        [self.tableView reloadData];
        [HUD hide:YES];
    }
}
@end
