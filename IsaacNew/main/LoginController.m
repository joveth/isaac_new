//
//  LoginController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/14.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"
#import "WebService.h"
#import "SVProgressHUD.h"
#import "DBHelper.h"
#import "RegisterController.h"

@interface LoginController ()

@end

@implementation LoginController{
    UITextField *name;
    UITextField *pass;
    UIButton *login;
    DBHelper *db;
    UIButton *reg;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户登录";
    db = [DBHelper sharedInstance];
    name = [[UITextField alloc] initWithFrame:CGRectMake(40, 80, self.view.frame.size.width-80, 40)];
    name.placeholder=@"用户名";
    name.borderStyle=UITextBorderStyleRoundedRect;
    name.delegate=self;
    name.clearButtonMode=UITextFieldViewModeAlways;
    [self.view addSubview:name];
    pass = [[UITextField alloc] initWithFrame:CGRectMake(40, 144, self.view.frame.size.width-80, 40)];
    pass.placeholder=@"密码";
    pass.delegate=self;
    pass.secureTextEntry=YES;
    pass.clearButtonMode=UITextFieldViewModeAlways;
    [self.view addSubview:pass];
    pass.borderStyle=UITextBorderStyleRoundedRect;
    login = [[UIButton alloc] initWithFrame:CGRectMake(40, 208, self.view.frame.size.width-80, 40)];
    [login setBackgroundColor:[Common colorWithHexString:@"#eb4f38"]];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:login];
    self.view.backgroundColor=[Common colorWithHexString:@"#e0e0e0"];
    [login addTarget:self  action:@selector(doLogin:) forControlEvents:UIControlEventTouchDown];
    
    reg = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 25, 40, 40)];
    [reg setTitle:@"注册" forState:UIControlStateNormal];
    [reg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reg addTarget:self  action:@selector(doReg:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview: reg];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [reg removeFromSuperview];
}

-(void)resginTxt{
    [name resignFirstResponder];
    [pass resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resginTxt];
    if(![Common isEmptyString:name.text]&&![Common isEmptyString:pass.text]){
        [self doLogin:nil];
    }
    return YES;
}
-(IBAction)doReg:(id)sender{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    RegisterController *show = [[RegisterController alloc] init];
    [self.navigationController pushViewController:show animated:YES];
}
-(IBAction)doLogin:(id)sender{
    if(![Common isEmptyString:name.text]&&![Common isEmptyString:pass.text]){
        [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeBlack];
        [WebService login:name.text andPass:pass.text andSuc:^(NSArray *_ret) {
            [SVProgressHUD dismiss];
            if(_ret&&[_ret count]>0){
                User *user =[_ret objectAtIndex:0];
                if(![Common isEmptyString:user.Name]){
                    [db saveUser:[_ret objectAtIndex:0]];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                 [Common showMessageWithOkButton:@"用户名或密码错误！"];
                }
            }else{
                [Common showMessageWithOkButton:@"用户名或密码错误！"];
            }
        } andErr:^(NSInteger code) {
            [SVProgressHUD dismiss];
            [Common showMessageWithOkButton:@"登录失败了，请稍后再试！"];
        }];
    }
}

@end
