//
//  Ver2Controller.m
//  IsaacNew
//
//  Created by Shuwei on 15/10/9.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "Ver2Controller.h"


@interface Ver2Controller ()

@end

@implementation Ver2Controller{
    UIView *topView,*content,*other;
    CGFloat width,avgWidth,avgHeight;
    NSInteger tag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"以撒的结合";
    width = self.view.frame.size.width;
    avgWidth = width/3;
    avgHeight = 90;
    CGFloat offset=64;
    self.view.backgroundColor=[Common colorWithHexString:@"e0e0e0"];
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, offset, width, 120)];
    topView.backgroundColor=FlatRed;
    [self.view addSubview:topView];
    offset+=140;
    content = [[UIView alloc] initWithFrame:CGRectMake(0, offset, width, 210)];
    content.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:content];
    offset+=230;
    other= [[UIView alloc] initWithFrame:CGRectMake(0, offset, width, 44)];
    other.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:other];
    tag=1;
    UIView *b0 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, avgWidth, 90)];
    UIImageView *i0 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 15, 50, 50)];
    i0.image = [UIImage imageNamed:@"home_search"];
    UILabel *l0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l0.font=[UIFont systemFontOfSize:18 weight:2];
    l0.textColor=FlatWhite;
    l0.textAlignment=NSTextAlignmentCenter;
    l0.text=@"图鉴";
    [b0 addSubview:i0];
    [b0 addSubview:l0];
    b0.tag=tag++;
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap0.cancelsTouchesInView=NO;
    tap0.delegate = self;
    [b0 addGestureRecognizer:tap0];
    [topView addSubview:b0];
    
    UIView *b1 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 10, avgWidth, 90)];
    UIImageView *i1 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 15, 50, 50)];
    i1.image = [UIImage imageNamed:@"home_boss"];
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l1.font=[UIFont systemFontOfSize:18 weight:2];
    l1.textColor=FlatWhite;
    l1.textAlignment=NSTextAlignmentCenter;
    l1.text=@"Boss";
    [b1 addSubview:i1];
    [b1 addSubview:l1];
    b1.tag=tag++;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap1.cancelsTouchesInView=NO;
    tap1.delegate = self;
    [b1 addGestureRecognizer:tap1];
    [topView addSubview:b1];
    
    UIView *b2 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 10, avgWidth, 90)];
    UIImageView *i2 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 15, 50, 50)];
    i2.image = [UIImage imageNamed:@"home_small"];
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l2.font=[UIFont systemFontOfSize:18 weight:2];
    l2.textColor=FlatWhite;
    l2.textAlignment=NSTextAlignmentCenter;
    l2.text=@"小怪";
    [b2 addSubview:i2];
    [b2 addSubview:l2];
    b2.tag=tag++;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap2.cancelsTouchesInView=NO;
    tap2.delegate = self;
    [b2 addGestureRecognizer:tap2];
    [topView addSubview:b2];
    
    UIView *b3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, avgWidth, 90)];
    UIImageView *i3 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 10, 50, 50)];
    i3.image = [UIImage imageNamed:@"home_mod"];
    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l3.font=[UIFont systemFontOfSize:16];
    l3.textColor=FlatBlack;
    l3.textAlignment=NSTextAlignmentCenter;
    l3.text=@"MOD合集";
    [b3 addSubview:i3];
    [b3 addSubview:l3];
    b3.tag=tag++;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap3.cancelsTouchesInView=NO;
    tap3.delegate = self;
    [b3 addGestureRecognizer:tap3];
    [content addSubview:b3];
    
    UIView *b4 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 0, avgWidth, 90)];
    UIImageView *i4 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 10, 50, 50)];
    i4.image = [UIImage imageNamed:@"home_seed"];
    UILabel *l4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l4.font=[UIFont systemFontOfSize:16];
    l4.textColor=FlatBlack;
    l4.textAlignment=NSTextAlignmentCenter;
    l4.text=@"Seed种子";
    [b4 addSubview:i4];
    [b4 addSubview:l4];
    b4.tag=tag++;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap4.cancelsTouchesInView=NO;
    tap4.delegate = self;
    [b4 addGestureRecognizer:tap4];
    [content addSubview:b4];
    
    UIView *b5 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 0, avgWidth, 90)];
    UIImageView *i5 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 10, 50, 50)];
    i5.image = [UIImage imageNamed:@"stor"];
    UILabel *l5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l5.font=[UIFont systemFontOfSize:16];
    l5.textColor=FlatBlack;
    l5.textAlignment=NSTextAlignmentCenter;
    l5.text=@"以撒的故事";
    [b5 addSubview:i5];
    [b5 addSubview:l5];
    b5.tag=tag++;
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap5.cancelsTouchesInView=NO;
    tap5.delegate = self;
    [b5 addGestureRecognizer:tap5];
    [content addSubview:b5];
    
    UIView *b6 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, avgWidth, 90)];
    UIImageView *i6 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 10, 50, 50)];
    i6.image = [UIImage imageNamed:@"home_luo"];
    UILabel *l6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l6.font=[UIFont systemFontOfSize:16];
    l6.textColor=FlatBlack;
    l6.textAlignment=NSTextAlignmentCenter;
    l6.text=@"基础掉落";
    [b6 addSubview:i6];
    [b6 addSubview:l6];
    b6.tag=tag++;
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap6.cancelsTouchesInView=NO;
    tap6.delegate = self;
    [b6 addGestureRecognizer:tap6];
    [content addSubview:b6];
    
    UIView *b7 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 100, avgWidth, 90)];
    UIImageView *i7 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 10, 50, 50)];
    i7.image = [UIImage imageNamed:@"earth"];
    UILabel *l7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l7.font=[UIFont systemFontOfSize:16];
    l7.textColor=FlatBlack;
    l7.textAlignment=NSTextAlignmentCenter;
    l7.text=@"地形物体";
    [b7 addSubview:i7];
    [b7 addSubview:l7];
    b7.tag=tag++;
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap7.cancelsTouchesInView=NO;
    tap7.delegate = self;
    [b7 addGestureRecognizer:tap7];
    [content addSubview:b7];
    
    UIView *b8 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 100, avgWidth, 90)];
    UIImageView *i8 = [[UIImageView alloc] initWithFrame:CGRectMake( (avgWidth-50)/2, 10, 50, 50)];
    i8.image = [UIImage imageNamed:@"home_room"];
    UILabel *l8 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, avgWidth, 25)];
    l8.font=[UIFont systemFontOfSize:16];
    l8.textColor=FlatBlack;
    l8.textAlignment=NSTextAlignmentCenter;
    l8.text=@"房间说明";
    [b8 addSubview:i8];
    [b8 addSubview:l8];
    b8.tag=tag++;
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap8.cancelsTouchesInView=NO;
    tap8.delegate = self;
    [b8 addGestureRecognizer:tap8];
    [content addSubview:b8];
    
    
    NSString *temp=@"二两三事" ;
    CGSize size=[temp sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:14.0f] forKey:NSFontAttributeName]];
    CGFloat x = avgWidth - size.width-30;
    UIView *other0 = [[UIView alloc] initWithFrame:CGRectMake(0, 2, avgWidth, 40)];
    UIImageView *otherimage0 = [[UIImageView alloc] initWithFrame:CGRectMake(x/2, 10, 20, 20)];
    otherimage0.image = [UIImage imageNamed:@"home_two"];
    UILabel *otherlabel0 = [[UILabel alloc] initWithFrame:CGRectMake(x/2+25, 10, size.width+5, 20)];
    otherlabel0.font=[UIFont systemFontOfSize:14];
    otherlabel0.textColor=[UIColor flatBlackColor];
    
    otherlabel0.text=temp;
    [other0 addSubview:otherimage0];
    [other0 addSubview:otherlabel0];
    other0.tag=tag++;
    UITapGestureRecognizer *tap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap8.cancelsTouchesInView=NO;
    tap8.delegate = self;
    [other0 addGestureRecognizer:tap9];
    [other addSubview:other0];
    
    temp = @"关于应用";
    size =[temp sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:14.0f] forKey:NSFontAttributeName]];
    x = avgWidth - size.width- 30;
    UIView *other1 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth, 2, avgWidth, 40)];
    UIImageView *otherimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(x/2, 10, 20, 20)];
    otherimage1.image = [UIImage imageNamed:@"about"];
    UILabel *otherlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(x/2+25, 10, size.width+5, 20)];
    otherlabel1.font=[UIFont systemFontOfSize:14];
    otherlabel1.textColor=[UIColor flatBlackColor];
    otherlabel1.text=@"关于应用";
    [other1 addSubview:otherimage1];
    [other1 addSubview:otherlabel1];
    other1.tag=tag++;
    UITapGestureRecognizer *tap10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap9.cancelsTouchesInView=NO;
    tap9.delegate = self;
    [other1 addGestureRecognizer:tap10];
    [other addSubview:other1];
    temp = @"给我留言";
    size =[temp sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:14.0f] forKey:NSFontAttributeName]];
    x = avgWidth - size.width- 30;
    UIView *other2 = [[UIView alloc] initWithFrame:CGRectMake(avgWidth*2, 2, avgWidth-5, 40)];
    UIImageView *otherimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(x/2, 10, 20, 20)];
    otherimage2.image = [UIImage imageNamed:@"message"];
    UILabel *otherlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(x/2+25, 10, size.width+5, 20)];
    otherlabel2.font=[UIFont systemFontOfSize:14];
    otherlabel2.textColor=[UIColor flatBlackColor];
    //otherlabel2.textAlignment=NSTextAlignmentCenter;
    otherlabel2.text=@"给我留言";//userContentWrapper,
    [other2 addSubview:otherimage2];
    [other2 addSubview:otherlabel2];
    other2.tag=tag;
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handler:)];
    tap10.cancelsTouchesInView=NO;
    tap10.delegate = self;
    [other2 addGestureRecognizer:tap11];
    [other addSubview:other2];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search2"] style:UIBarButtonItemStyleBordered target:self action:@selector(doSearch:)];
    rightItem.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =rightItem;
}

-(IBAction)doSearch:(id)sender{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    SearchViewController *show = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:show animated:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)handler :(UITapGestureRecognizer *)sender{
    NSLog(@"tag=%ld",sender.view.tag);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    switch (sender.view.tag) {
        case 1:{
            IsaacTableViewController *show = [[IsaacTableViewController alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 2:{
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width/3-10,90)]; //设置每个cell显示数据的宽和高必须
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
            BossController *show = [[BossController alloc] initWithCollectionViewLayout:flowLayout];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 3:{
            SmallController *show = [[SmallController alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 4:{
            ModController *show = [[ModController alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 5:{
             break;
        }
        case 6:{
             break;
        }
        case 7:{
            [ShareData shareInstance].type=@"1";
            AboutSomething *show = [[AboutSomething alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 8:{
            [ShareData shareInstance].type=@"2";
            AboutSomething *show = [[AboutSomething alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
            break;
        }
        case 9:{
            [ShareData shareInstance].type=@"3";
            AboutSomething *show = [[AboutSomething alloc] init];
            [self.navigationController pushViewController:show animated:YES];
            break;
        }
        case 10:{
            
            break;
        }
        case 11:{
            
            break;
        }
        case 12:{
            break;
        }
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
