//
//  SearchViewController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/14.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "SearchViewController.h"
#import "IsaacBean.h"
#import "Common.h"
#import "DBHelper.h"
#import "ShareData.h"
#import "ShowSearchController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController{
    UISearchController *searchController;
    UISearchBar *searchBar;
    NSMutableArray *list;
    DBHelper *db;
    UIButton *menuBtn;
    UIBarButtonItem *rightItem;
    BOOL showContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [DBHelper sharedInstance];
    searchController= [[UISearchController alloc] initWithSearchResultsController:nil];
    list =[[NSMutableArray alloc] init];
    searchController.searchResultsUpdater = self;
    
    searchController.dimsBackgroundDuringPresentation = YES;
    
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.frame = CGRectMake(searchController.searchBar.frame.origin.x,searchController.searchBar.frame.origin.y, searchController.searchBar.frame.size.width, 44.0);
    searchController.searchBar.placeholder=@"搜索";
    self.title=@"全图鉴搜索";
    showContent = YES;
    self.tableView.tableHeaderView = searchController.searchBar;
    rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"switch_on"] style:UIBarButtonItemStyleBordered target:self action:@selector(doSwitch:)];
    rightItem.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =rightItem;
    
}
-(IBAction)doSwitch:(id)sender{
    if([list count]==0){
        return;
    }
    [rightItem setImage:[UIImage imageNamed:@"switch_on"]];
    if(showContent){
        [rightItem setImage:[UIImage imageNamed:@"switch_off"]];
    }
    showContent = !showContent;
    [self.tableView reloadData];
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[searchBar removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellidentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = [UIColor greenColor];
    }
    UILabel *nameLabel =(UILabel*)[cell viewWithTag:1];
    UIImageView *image=(UIImageView*)[cell viewWithTag:2];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:3];
    if(nameLabel==nil){
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, self.view.frame.size.width-55, 22)];
        nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        nameLabel.numberOfLines=0;
        nameLabel.tag=1;
        [cell addSubview:nameLabel];
    }
    if(image==nil){
        image = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 30, 30)];
        image.tag=2;
        [cell addSubview:image];
    }
    if(contentLabel==nil){
        contentLabel = [[UILabel alloc] init];
        contentLabel.lineBreakMode=NSLineBreakByWordWrapping;
        contentLabel.numberOfLines=0;
        contentLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        contentLabel.tag=3;
        [cell addSubview:contentLabel];
    }
    if(!showContent){
        contentLabel.hidden=YES;
    }else{
        contentLabel.hidden=NO;
    }
    IsaacBean *bean= [list objectAtIndex:indexPath.row];
    if(bean){
        nameLabel.text = [NSString stringWithFormat:@"%@(%@)",bean.name,bean.enName];
        if(![Common isEmptyString:bean.image]){
            image.image = [UIImage imageNamed:bean.image];
        }else{
            image.image=nil;
        }
        contentLabel.text = bean.content;
        if(![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:14.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-55;
            CGFloat line = size.width/width;
            line = [Common clcLine:line];
            contentLabel.frame=CGRectMake(50, 30, self.view.frame.size.width-55, size.height*line+30);
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    IsaacBean  * bean = [list objectAtIndex:indexPath.row];
    if(bean){
        
        if(showContent&&![Common isEmptyString:bean.content]){
            CGSize size = [bean.content sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:14.0f] forKey:NSFontAttributeName]];
            CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-55;
            CGFloat line = size.width/width;
            line = [Common clcLine:line];
            return size.height*(line+1)+44;
        }
    }
    return 44;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([Common isEmptyString:searchText]){
        [list removeAllObjects];
    }else{
        list = [db getIsaacsByKey:searchText];
    }
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [searchController reloadInputViews];
    ShowSearchController *show = [[ShowSearchController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    [ShareData shareInstance].isaacBean = [list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:show animated:YES];
}
-(void)updateSearchResultsForSearchController:(UISearchController *)sController {
     NSString *searchString = [searchController.searchBar text];
    if(![Common isEmptyString:searchString]){
       list = [db getIsaacsByKey:searchString];
        [self.tableView reloadData];
    }
}
@end
