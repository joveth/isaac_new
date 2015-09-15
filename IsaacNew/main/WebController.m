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
#import "SVProgressHUD.h"

@interface WebController ()<UIWebViewDelegate>

@end

@implementation WebController{
    UIWebView *webview;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.title=[ShareData shareInstance].title;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/m/show/%@",WEB_BASE_URL,[ShareData shareInstance].urltype]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self showSV];
    webview.delegate=self;
    [webview loadRequest:req];
    [self.view addSubview:webview];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)showSV{
    dispatch_async(dispatch_get_main_queue(),^ {
        [SVProgressHUD show];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败了"];
}

@end
