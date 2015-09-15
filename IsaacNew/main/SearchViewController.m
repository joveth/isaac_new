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
    UISearchDisplayController *searchController;
    UISearchBar *searchBar;
    NSMutableArray *list;
    DBHelper *db;
    UIButton *menuBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    db = [DBHelper sharedInstance];
    searchController= [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    list =[[NSMutableArray alloc] init];
    [searchBar setPlaceholder:@"搜索"];
    searchBar.delegate = self;
    searchBar.backgroundColor=[UIColor redColor];
    searchController.searchResultsDelegate= self;
    searchController.searchResultsDataSource = self;
    searchController.delegate = self;
    [searchBar sizeToFit];
    [searchBar becomeFirstResponder];
    self.title=@"搜索结果";
    [self.navigationController.view addSubview: searchBar];
    menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 25, 40, 40)];
    [menuBtn setImage:[UIImage imageNamed:@"search2"] forState:UIControlStateNormal];
    [menuBtn setTintColor:[UIColor whiteColor]];
    [self.navigationController.view addSubview: menuBtn];
    [menuBtn addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchDown];
    CGRect frame=self.tableView.frame;
    frame.origin.y+=60;
    self.tableView.frame =frame;
}

-(IBAction)doSearch:(id)sender{
    [self.navigationController.view addSubview: searchBar];
    [searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview: searchBar];
    [searchBar becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [searchBar removeFromSuperview];
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
    IsaacBean *bean= [list objectAtIndex:indexPath.row];
    if(bean){
        if([Common isEmptyString:bean.enName]){
            cell.textLabel.text = bean.name;
        }else{
            cell.textLabel.text =[NSString stringWithFormat:@"%@(%@)",bean.name,bean.enName];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
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
    ShowSearchController *show = [[ShowSearchController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    [ShareData shareInstance].isaacBean = [list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:show animated:YES];
}

@end
