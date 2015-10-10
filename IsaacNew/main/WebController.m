//
//  WebController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/14.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "WebController.h"
#import "ShareData.h"
#import "SWDefine.h"
#import "MBProgressHUD.h"

@interface WebController ()<UIWebViewDelegate>

@end

@implementation WebController{
    UIWebView *webview;
    MBProgressHUD *HUD;
    NSURLRequest *req;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"加载中...";
    [HUD show:YES];
    webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    //self.title=[ShareData shareInstance].title;
    NSURL *url = [NSURL URLWithString:[ShareData shareInstance].urltype];
    req = [NSURLRequest requestWithURL:url];
    webview.delegate=self;
    [self.view addSubview:webview];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)viewDidAppear:(BOOL)animated{
    [webview loadRequest:req];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [HUD hide:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [HUD hide:YES];
}

@end
