//
//  RegisterController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/14.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "RegisterController.h"
#import "Common.h"
#import "WebService.h"
#import "SVProgressHUD.h"
#import "DBHelper.h"
@interface RegisterController ()

@end

@implementation RegisterController{
    UITextField *name;
    UITextField *email;
    UITextField *pass;
    UITextField *repass;
    UIButton *login;
    DBHelper *db;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title=@"用户注册";
    db = [DBHelper sharedInstance];
    CGFloat y = 80;
    name = [[UITextField alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width-80, 30)];
    name.placeholder=@"用户名";
    name.borderStyle=UITextBorderStyleRoundedRect;
    name.delegate=self;
    [self.view addSubview:name];
    y+=40;
    email = [[UITextField alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width-80, 30)];
    email.placeholder=@"邮箱/手机";
    email.borderStyle=UITextBorderStyleRoundedRect;
    email.delegate=self;
    [self.view addSubview:email];
    y+=40;
    pass = [[UITextField alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width-80, 30)];
    pass.placeholder=@"密码";
    pass.delegate=self;
    pass.secureTextEntry=YES;
    pass.clearButtonMode=UITextFieldViewModeAlways;
    pass.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:pass];
    y+=40;
    repass = [[UITextField alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width-80, 30)];
    repass.placeholder=@"确认密码";
    repass.delegate=self;
    repass.secureTextEntry=YES;
    repass.clearButtonMode=UITextFieldViewModeAlways;
    repass.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:repass];
    y+=40;
    login = [[UIButton alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width-80, 40)];
    [login setBackgroundColor:[Common colorWithHexString:@"#eb4f38"]];
    [login setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:login];
    self.view.backgroundColor=[Common colorWithHexString:@"#e0e0e0"];
    [login addTarget:self  action:@selector(doReg:) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)resginTxt{
    [name resignFirstResponder];
    [pass resignFirstResponder];
    [email resignFirstResponder];
    [repass resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resginTxt];
    return YES;
}

-(IBAction)doReg:(id)sender{
    if(![Common isEmptyString:name.text]&&![Common isEmptyString:pass.text]&&![Common isEmptyString:email.text]&&![Common isEmptyString:repass.text]){
        if(name.text.length<3){
            [Common showMessageWithOkButton:@"用户名至少3位！"];
            return;
        }
        if(pass.text.length<6){
            [Common showMessageWithOkButton:@"密码长度至少6位！"];
            return;
        }
        if(![repass.text isEqualToString:pass.text]){
            [Common showMessageWithOkButton:@"两次密码不一致！"];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在处理" maskType:SVProgressHUDMaskTypeBlack];
        [WebService regist:name.text andPass:pass.text andEmail:email.text andSuc:^(NSArray *_ret) {
            [SVProgressHUD dismiss];
            if(_ret&&[_ret count]>0){
                User *user =[_ret objectAtIndex:0];
                if(![Common isEmptyString:user.Name]){
                    [db saveUser:[_ret objectAtIndex:0]];
                    [Common showMessage:@"注册成功，您可以登录系统了" seconds:1];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [Common showMessageWithOkButton:user.Email];
                }
            }else{
                [Common showMessageWithOkButton:@"处理失败了，请稍后再试！"];
            }
        } andErr:^(NSInteger code) {
            [SVProgressHUD dismiss];
            [Common showMessageWithOkButton:@"处理失败了，请稍后再试！"];
        }];
    }
}

@end
