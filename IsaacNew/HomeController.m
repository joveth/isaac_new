//
//  HomeController.m
//  Isaac
//
//  Created by Shuwei on 15/8/31.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "HomeController.h"
#import "Common.h"
#import "IsaacTableViewController.h"
#import "NewsController.h"
#import "PKRevealController.h"

@interface HomeController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *search;
@property (nonatomic, strong, readwrite) PKRevealController *revealController;
@property (nonatomic, strong, readwrite) UIViewController *theViewController;
@property (nonatomic, strong, readwrite) UIViewController *leftTab;
@end

@implementation HomeController{
    UISearchDisplayController *searchController;
    UISearchBar *searchBar;
    UIButton *userLogo;
    
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50,
                                                                    22,
                                                                    self.navigationController.view.bounds.size.width-100,
                                                                    40)];
    searchBar.placeholder=@"搜索";
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    userLogo = [[UIButton alloc] initWithFrame:CGRectMake(20,28,32,32)];
    userLogo.frame = CGRectMake(20,28,32,32);
    userLogo.backgroundColor=[UIColor whiteColor];
    userLogo.layer.cornerRadius=16;
    userLogo.layer.masksToBounds=YES;
    [userLogo setImage:[UIImage imageNamed:@"me.jpg"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [userLogo addTarget:self action:@selector(startPresentationMode) forControlEvents:UIControlEventTouchDown];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.revealController = [[PKRevealController alloc] init];
    self.revealController.frontViewController=[[UIViewController alloc] init];
    self.revealController.leftViewController=[[UIViewController alloc] init];
    
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 100, 100)];
    self.revealController.leftViewController.view.backgroundColor=[Common colorWithHexString:@"eb4f38"];
    tab.backgroundColor = [Common colorWithHexString:@"eb4f38"];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(0, 30, 100, 40)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    //[header addSubview:button];
    [self.revealController.leftViewController.view addSubview:header];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview: userLogo];
}
-(IBAction)presetMenu:(id)sender{
    [self.revealController showViewController:self.revealController.leftViewController animated:YES completion:nil];
}


- (void)startPresentationMode
{
    NSLog(@"clicked");
    if (![self.revealController isPresentationModeActive])
    {
        [self.revealController showViewController:self.revealController.leftViewController animated:YES completion:nil];
    }
    else
    {
        [self.revealController resignPresentationModeEntirely:NO animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:1] ;
    UIImageView *image =(UIImageView *)[cell.contentView viewWithTag:2] ;
    CGFloat width=self.view.frame.size.width/3;
    if(name==nil){
        name = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, width-10, 20)];
        name.tag = 1;
        name.textAlignment=NSTextAlignmentCenter;
        name.textColor = [Common colorWithHexString:@"eb4f38"];
        [cell.contentView addSubview:name];
    }
    if(image==nil){
        image = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-22, 10, 44, 44)];
        image.tag = 2;
        [cell.contentView addSubview:image];
    }
    if(indexPath.row==0){
        name.text=@"图鉴";
        image.image=[UIImage imageNamed:@"s"];
    }else if(indexPath.row==1){
        name.text=@"Boss";
        image.image=[UIImage imageNamed:@"b1"];
    }else if(indexPath.row==2){
        name.text=@"小怪";
        image.image=[UIImage imageNamed:@"l"];
    }else if(indexPath.row==3){
        name.text=@"以撒のNews";
        image.image=[UIImage imageNamed:@"news"];
    }else if(indexPath.row==4){
        name.text=@"MOD合集";
        image.image=[UIImage imageNamed:@"mod"];
    }else if(indexPath.row==5){
        name.text=@"各种Seed";
        image.image=[UIImage imageNamed:@"seed"];
    }else if(indexPath.row==6){
        name.text=@"以撒同人";
        image.image=[UIImage imageNamed:@"same"];
    }else if(indexPath.row==7){
        name.text=@"萌萌哒手绘";
        image.image=[UIImage imageNamed:@"pic"];
    }else if(indexPath.row==8){
        name.text=@"故事会";
        image.image=[UIImage imageNamed:@"stor"];
    }else if(indexPath.row==9){
        name.text=@"基础掉落";
        image.image=[UIImage imageNamed:@"luo"];
    }else if(indexPath.row==10){
        name.text=@"地形物体";
        image.image=[UIImage imageNamed:@"earth"];
    }else if(indexPath.row==11){
        name.text=@"房间的说";
        image.image=[UIImage imageNamed:@"room"];
    }else if(indexPath.row==12){
        name.text=@"Boss Rush";
        image.image=[UIImage imageNamed:@"rush"];
    }else if(indexPath.row==13){
        name.text=@"更多";
        image.image=[UIImage imageNamed:@"mor"];

    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize returnSize = CGSizeMake(self.view.frame.size.width/3-10, 90);
    return returnSize;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //UIViewController *show;
    if(indexPath.row==3){
        NewsController *show = [[NewsController alloc] init];
        [userLogo removeFromSuperview];
        //self.navigationController = [[UINavigationController alloc] initWithRootViewController:self];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        backItem.tintColor=[UIColor whiteColor];
        [self.navigationItem setBackBarButtonItem:backItem];
        [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:show animated:YES];
    }
}

@end
