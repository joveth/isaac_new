//
//  MainController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/30.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@end

@implementation MainController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:1] ;
    UIImageView *image =(UIImageView *)[cell.contentView viewWithTag:2] ;
    CGFloat width=self.view.frame.size.width/3;
    if(name==nil){
        name = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, width-10, 20)];
        
        name.tag = 1;
        name.textAlignment=NSTextAlignmentCenter;
        name.textColor = [Common colorWithHexString:@"eb4f38"];
        [cell.contentView addSubview:name];
    }
    if(image==nil){
        image = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-22, 10, 50, 50)];
        
        image.tag = 2;
        [cell.contentView addSubview:image];
    }
    cell.backgroundColor=[UIColor whiteColor];
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
    }
    //    else if(indexPath.row==6){
    //        name.text=@"以撒同人";
    //        image.image=[UIImage imageNamed:@"same"];
    //    }else if(indexPath.row==7){
    //        name.text=@"萌萌哒手绘";
    //        image.image=[UIImage imageNamed:@"pic"];
    //    }
    else if(indexPath.row==6){
        name.text=@"故事会";
        image.image=[UIImage imageNamed:@"stor"];
    }else if(indexPath.row==7){
        name.text=@"基础掉落";
        image.image=[UIImage imageNamed:@"luo"];
    }else if(indexPath.row==8){
        name.text=@"地形物体";
        image.image=[UIImage imageNamed:@"earth"];
    }else if(indexPath.row==9){
        name.text=@"房间的说";
        image.image=[UIImage imageNamed:@"room"];
    }else if(indexPath.row==10){
        name.text=@"Boss Rush";
        image.image=[UIImage imageNamed:@"rush"];
    }else if(indexPath.row==11){
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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    if(indexPath.row==0){
        IsaacTableViewController *show = [[IsaacTableViewController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==1){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width/3-10,90)]; //设置每个cell显示数据的宽和高必须
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
        BossController *show = [[BossController alloc] initWithCollectionViewLayout:flowLayout];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==2){
        SmallController *show = [[SmallController alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==3){
        NewsController *show = [[NewsController alloc] init];
        [ShareData shareInstance].urltype=@"1";
        [ShareData shareInstance].title=@"以撒新闻";
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==4){
        NewsController *show = [[NewsController alloc] init];
        [ShareData shareInstance].urltype=@"7";
        [ShareData shareInstance].title=@"MOD合集";
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==5){
        NewsController *show = [[NewsController alloc] init];
        [ShareData shareInstance].urltype=@"8";
        [ShareData shareInstance].title=@"各种Seed";
        [self.navigationController pushViewController:show animated:YES];
    }
    //    else if(indexPath.row==6){
    //        NewsController *show = [[NewsController alloc] init];
    //        [ShareData shareInstance].urltype=@"3";
    //        [ShareData shareInstance].title=@"同人文";
    //        [self.navigationController pushViewController:show animated:YES];
    //    }else if(indexPath.row==7){
    //        NewsController *show = [[NewsController alloc] init];
    //        [ShareData shareInstance].urltype=@"4";
    //        [ShareData shareInstance].title=@"手绘";
    //        [self.navigationController pushViewController:show animated:YES];
    //    }
    else if(indexPath.row==6){
        NewsController *show = [[NewsController alloc] init];
        [ShareData shareInstance].urltype=@"11";
        [ShareData shareInstance].title=@"以撒的故事";
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==7){
        [ShareData shareInstance].type=@"1";
        
        AboutSomething *show = [[AboutSomething alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==8){
        [ShareData shareInstance].type=@"2";
        
        AboutSomething *show = [[AboutSomething alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==9){
        [ShareData shareInstance].type=@"3";
        AboutSomething *show = [[AboutSomething alloc] init];
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==10){
        MoreOther *show =[[MoreOther alloc] init];
        [ShareData shareInstance].type=@"1";
        [self.navigationController pushViewController:show animated:YES];
    }else if(indexPath.row==11){
        MoreController *show =[[MoreController alloc] init];
        show.title=@"更多";
        [self.navigationController pushViewController:show animated:YES];
    }
}
- (IBAction)searchClick:(id)sender {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    SearchViewController *show = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:show animated:YES];
}

@end
