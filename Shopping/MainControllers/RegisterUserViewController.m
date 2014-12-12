//
//  RegisterUserViewController.m
//  EducationApp
//
//  Created by Darwin on 14/11/18.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "JSONKit.h"

@interface RegisterUserViewController ()

@end

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImg"]];
    bgImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:bgImageView];
    
    
    UIImageView *nameBg0 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+40, 125, 240, 41)];
    nameBg0.userInteractionEnabled = YES;
    nameBg0.image = [UIImage imageNamed:@"inputBg"];
    [self.view addSubview:nameBg0];
    UIImageView *nameImg0 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 21, 23)];
    nameImg0.image = [UIImage imageNamed:@"icon_01"];
    [nameBg0 addSubview:nameImg0];
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 8, 175, 25)];
    self.nameTextField.backgroundColor = [UIColor clearColor];
    self.nameTextField.font = [UIFont systemFontOfSize:15];
    self.nameTextField.placeholder = @"输入昵称";
    self.nameTextField.tag = 10;
    self.nameTextField.delegate = self;
    [nameBg0 addSubview:self.nameTextField];
    
    UIImageView *nameBg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+40, nameBg0.frame.origin.y+50, 240, 41)];
    nameBg.userInteractionEnabled = YES;
    nameBg.image = [UIImage imageNamed:@"inputBg"];
    [self.view addSubview:nameBg];
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 22, 18)];
    nameImg.image = [UIImage imageNamed:@"icon_02"];
    [nameBg addSubview:nameImg];
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 8, 175, 25)];
    self.emailTextField.backgroundColor = [UIColor clearColor];
    self.emailTextField.font = [UIFont systemFontOfSize:15];
    self.emailTextField.placeholder = @"输入邮箱";
    self.emailTextField.tag = 15;
    self.emailTextField.delegate = self;
    [nameBg addSubview:self.emailTextField];
    
    
    UIImageView *nameBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+40, nameBg.frame.origin.y+50, 240, 42)];
    nameBg1.userInteractionEnabled = YES;
    nameBg1.image = [UIImage imageNamed:@"inputBg"];
    [self.view addSubview:nameBg1];
    UIImageView *nameImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 21, 23)];
    nameImg1.image = [UIImage imageNamed:@"icon_03"];
    [nameBg1 addSubview:nameImg1];
    self.passwordTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(45, 8, 175, 25)];
    self.passwordTextField2.backgroundColor = [UIColor clearColor];
    self.passwordTextField2.font = [UIFont systemFontOfSize:15];
    self.passwordTextField2.placeholder = @"输入密码";
    self.passwordTextField2.tag = 30;
    self.passwordTextField2.secureTextEntry = YES;
    self.passwordTextField2.delegate = self;
    [nameBg1 addSubview:self.passwordTextField2];
    
    UIImageView *nameBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+40, nameBg1.frame.origin.y+50, 240, 42)];
    nameBg2.userInteractionEnabled = YES;
    nameBg2.image = [UIImage imageNamed:@"inputBg"];
    [self.view addSubview:nameBg2];
    UIImageView *nameImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 21, 23)];
    nameImg2.image = [UIImage imageNamed:@"icon_03"];
    [nameBg2 addSubview:nameImg2];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 8, 175, 25)];
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.font = [UIFont systemFontOfSize:15];
    self.passwordTextField.placeholder = @"确认密码";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.tag = 20;
    self.passwordTextField.delegate = self;
    [nameBg2 addSubview:self.passwordTextField];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(self.view.frame.size.width-320+40, nameBg2.frame.origin.y+50, 240, 41);
    self.registerButton.backgroundColor = [UIColor clearColor];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"signUpSubmit"] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"signUpSubmit"] forState:UIControlStateHighlighted];
    [self.registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton.tag = 400;
    [self.view addSubview:self.registerButton];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       // return NO to disallow editing.
{
    return YES;
}



- (void)hideKeyBoard
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordTextField2 resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.passwordTextField]) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if ([textField isEqual:self.passwordTextField2]){
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, -60, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if ([textField isEqual:self.emailTextField]){
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, -10, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    //不允许输入回车
    if ([string isEqualToString:@"\n"]){
        [self hideKeyBoard];
        return NO;
    }
    return YES;
}

//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)registerUser{
    [self hideKeyBoard];
    if (self.nameTextField.text.length<1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"请输入您的昵称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else if (self.nameTextField.text.length>10){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的昵称长度应小于十个字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else if(self.emailTextField.text.length<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您尚未输入邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else if([self isValidateEmail:self.emailTextField.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的邮箱格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

    }else if(self.passwordTextField.text.length<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您尚未输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else if(self.passwordTextField2.text.length<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您尚未确认密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else if([self.passwordTextField.text isEqualToString:self.passwordTextField2.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您输入的密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else{
        NetWorkManager *netWork = [[NetWorkManager alloc] init];
        netWork.delegete = self;
        netWork.dataType = @"userRegister";
        [netWork getDataWithRequestPath:@"/account/mobile/signup" andParameters:@{@"name":self.nameTextField.text,@"email":self.emailTextField.text,@"pwd":self.passwordTextField.text}andRequestType:0];
    }
    
}

- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"userRegister"]){
        NSDictionary *dic = [responseString objectFromJSONString];
        if ([dic isEqual:[NSNull null]] || [dic isEqual:nil] ||[dic description].length == 6) {
            return;
        }else{
            if (((NSNumber *)[dic objectForKey:@"type"]).intValue == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册失败" message:[dic objectForKey:@"error"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
