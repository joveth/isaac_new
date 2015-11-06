//
//  MoreOther.m
//  Isaac
//
//  Created by Shuwei on 15/7/31.
//  Copyright (c) 2015年 Shuwei. All rights reserved.
//

#import "MoreOther.h"
#import "ShareData.h"

@interface MoreOther ()

@end

@implementation MoreOther{
    UIWebView *web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *type = [ShareData shareInstance].type;
    if(type==nil){
        type=@"1";
    }
    if([type isEqualToString:@"1"]){
        self.title = @"Boss Rush";
    }else if([type isEqualToString:@"2"]){
        self.title = @"捐款机&献血机";
    }else if([type isEqualToString:@"3"]){
        self.title = @"猫套&苍蝇套";
    }
    self.view.backgroundColor=[UIColor whiteColor];
    web = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:type ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [web loadHTMLString:html baseURL:baseURL];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
