//
//  LoginViewController.m
//  EducationApp
//
//  Created by Darwin on 14/11/17.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterUserViewController.h"
#import "RootTabbarViewController.h"
#import "JSONKit.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImg"]];
    bgImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:bgImageView];
    
    UIImageView *bgImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImg"]];
    bgImageView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.navigationController.view addSubview:bgImageView1];
    [self.navigationController.view sendSubviewToBack:bgImageView1];
    
    self.qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qqButton.backgroundColor = [UIColor clearColor];
    [self.qqButton setBackgroundImage:[UIImage imageNamed:@"qqSignbtn"] forState:UIControlStateNormal];
    [self.qqButton setBackgroundImage:[UIImage imageNamed:@"qqSignbtnClick"] forState:UIControlStateHighlighted];
    self.qqButton.tag = 100;
    [self.qqButton addTarget:self action:@selector(logInWithThirdTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qqButton];
    
    self.sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sinaButton.backgroundColor = [UIColor clearColor];
    [self.sinaButton setBackgroundImage:[UIImage imageNamed:@"weiboSignbtn"] forState:UIControlStateNormal];
    [self.sinaButton setBackgroundImage:[UIImage imageNamed:@"weiboSignbtnClick"] forState:UIControlStateHighlighted];
    self.sinaButton.tag = 200;
    [self.sinaButton addTarget:self action:@selector(logInWithThirdTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sinaButton];
    
    self.wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wechatButton.backgroundColor = [UIColor clearColor];
    [self.wechatButton setBackgroundImage:[UIImage imageNamed:@"weixinSignbtn"] forState:UIControlStateNormal];
    [self.wechatButton setBackgroundImage:[UIImage imageNamed:@"weixinSignbtnClick"] forState:UIControlStateHighlighted];
    self.wechatButton.tag = 300;
    [self.wechatButton addTarget:self action:@selector(logInWithThirdTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wechatButton];
    
    self.qqButton.frame = CGRectMake(self.view.frame.size.width-320+40, -20, 56, 124);
    self.sinaButton.frame = CGRectMake(self.view.frame.size.width/2-28, 0, 56, 124);
    self.wechatButton.frame = CGRectMake(self.view.frame.size.width-320+320-96, -20, 56, 124);
    
    UIView *lefthr = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width-320+(320-120)/2, 1.2)];
    lefthr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lefthr];
    
    UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(lefthr.frame.size.width +5, 142, 120, 20)];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.font = [UIFont boldSystemFontOfSize:16];
    centerLabel.text = @"用以上方式登录";
    [self.view addSubview:centerLabel];
    
    UIView *righthr = [[UIView alloc] initWithFrame:CGRectMake(centerLabel.frame.size.width+centerLabel.frame.origin.x+5, 150, self.view.frame.size.width-320+(320-120)/2, 1.2)];
    righthr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:righthr];
    
    

    UIImageView *nameBg0 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+41, 185, 126, 41)];
    nameBg0.userInteractionEnabled = YES;
    nameBg0.image = [UIImage imageNamed:@"teachImg"];
    [self.view addSubview:nameBg0];
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake(nameBg0.frame.origin.x+138, 185, 102, 42);
    self.registerButton.backgroundColor = [UIColor clearColor];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"signupBtn"] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"signupBtnClick"] forState:UIControlStateHighlighted];
    [self.registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];

    
    UIImageView *nameBg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+40, 185+50, 240, 41)];
    nameBg.userInteractionEnabled = YES;
    nameBg.image = [UIImage imageNamed:@"inputBg"];
    [self.view addSubview:nameBg];
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 22, 18)];
    nameImg.image = [UIImage imageNamed:@"icon_02"];
    [nameBg addSubview:nameImg];
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 8, 175, 25)];
    self.nameTextField.backgroundColor = [UIColor clearColor];
    self.nameTextField.font = [UIFont systemFontOfSize:15];
    self.nameTextField.placeholder = @"输入邮箱";
    self.nameTextField.tag = 10;
    self.nameTextField.delegate = self;
    [nameBg addSubview:self.nameTextField];
    
    
    UIImageView *nameBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-320+40, nameBg.frame.origin.y+50, 240, 42)];
    nameBg2.userInteractionEnabled = YES;
    nameBg2.image = [UIImage imageNamed:@"inputBg"];
    [self.view addSubview:nameBg2];
    UIImageView *nameImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 21, 23)];
    nameImg2.image = [UIImage imageNamed:@"icon_03"];
    [nameBg2 addSubview:nameImg2];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 8, 175, 25)];
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.font = [UIFont systemFontOfSize:15];
    self.passwordTextField.placeholder = @"输入密码";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.tag = 20;
    self.passwordTextField.delegate = self;
    [nameBg2 addSubview:self.passwordTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(self.view.frame.size.width-320+39, nameBg2.frame.origin.y+50, 244, 41);
    self.loginButton.backgroundColor = [UIColor clearColor];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"signbtn"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"signbtnClick"] forState:UIControlStateHighlighted];
    
    self.loginButton.tag = 400;
    [self.loginButton addTarget:self action:@selector(logInWithThirdTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
}

- (void)registerUser{
    [self hideKeyBoard];
    RegisterUserViewController *registerUser = [[RegisterUserViewController alloc] init];
    [self.navigationController pushViewController:registerUser animated:YES];
}


//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


- (void)logInWithThirdTarget:(UIButton *)sender {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self hideKeyBoard];
    //设置回调对象
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    
    UserManager *userManager = [UserManager sharedManager];
    userManager.isOnline = NO;
    if (sender.tag == 100) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            NSLog(@"%@",response);
            if (((NSString *)[response.data objectForKey:@"qq"]).description.length>0) {
                userManager.qqUserDic = [NSMutableDictionary dictionaryWithDictionary:[response.data objectForKey:@"qq"]];
                userManager.isOnline = YES;
                userManager.onlineType = @"qq";
                [userManager configUser];
                RootTabbarViewController *rootView = [[RootTabbarViewController alloc] init];
                [self presentViewController:rootView animated:YES completion:nil];
            }
        });
        //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
        }];
        
    }else if(sender.tag == 200){
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
            {
                NSLog(@"%@",response);
                if (((NSString *)[response.data objectForKey:@"sina"]).description.length>0) {
                    userManager.sinaUserDic = [NSMutableDictionary dictionaryWithDictionary:[response.data objectForKey:@"sina"]];
                    userManager.isOnline = YES;
                    userManager.onlineType = @"sina";
                    [userManager configUser];
                    RootTabbarViewController *rootView = [[RootTabbarViewController alloc] init];
                    [self presentViewController:rootView animated:YES completion:nil];
                }
                
            });
    }else if (sender.tag == 300){
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            NSLog(@"%@",response);
            if (((NSString *)[response.data objectForKey:@"wechat"]).description.length>0) {
                userManager.weichatUserDic = [NSMutableDictionary dictionaryWithDictionary:[response.data objectForKey:@"wechat"]];
                userManager.isOnline = YES;
                userManager.onlineType = @"wechat";
                [userManager configUser];
                RootTabbarViewController *rootView = [[RootTabbarViewController alloc] init];
                [self presentViewController:rootView animated:YES completion:nil];
            }
        });
        //得到的数据在回调Block对象形参respone的data属性
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
            NSLog(@"SnsInformation is %@",response.data);
        }];
        
    }else if (sender.tag == 400){
        
        if (self.nameTextField.text.length<1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"请输入您的邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else if([self isValidateEmail:self.nameTextField.text] == NO){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的邮箱格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }else if(self.passwordTextField.text.length<1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您尚未输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }else{
            NetWorkManager *netWork = [[NetWorkManager alloc] init];
            netWork.delegete = self;
            netWork.dataType = @"userlogin";
            [netWork getDataWithRequestPath:@"/account/mobile/signin" andParameters:@{@"email":self.nameTextField.text,@"pwd":self.passwordTextField.text}andRequestType:0];
        }
    }
}


- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"userlogin"]){
        NSDictionary *dic = [responseString objectFromJSONString];
        if ([dic isEqual:[NSNull null]] || [dic isEqual:nil] ||[dic description].length == 6) {
            return;
        }else{
            if (((NSNumber *)[dic objectForKey:@"type"]).intValue == 1) {
                UserManager *userManager = [UserManager sharedManager];
                userManager.isOnline = YES;
                dic = [dic objectForKey:@"result"];
                userManager.onlineType = @"login";
                userManager.token = [dic objectForKey:@"token"];
                userManager.userID = [dic objectForKey:@"id"];
                userManager.imagePath = [dic objectForKey:@"icon"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:self.nameTextField.text forKey:@"userMail"];
                [user setObject:self.passwordTextField.text forKey:@"pwd"];
                [user setObject:userManager.token forKey:@"token"];
                [user setObject:userManager.userID forKey:@"userID"];
                [user setObject:userManager.imagePath forKey:@"imagePath"];
                [user synchronize];
                [userManager configUser];
                
                RootTabbarViewController *rootView = [[RootTabbarViewController alloc] init];
                [self presentViewController:rootView animated:YES completion:nil];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[dic objectForKey:@"error"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
    
}


//实现授权回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.viewControllerType == UMSViewControllerOauth) {
        NSLog(@"didFinishOauthAndGetAccount response is %@",response);
    }
}

- (void)hideKeyBoard
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.nameTextField]) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, -75, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if ([textField isEqual:self.passwordTextField]) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       // return NO to disallow editing.
{
    return YES;
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


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *onlineType = [user objectForKey:@"onlineType"];
    if (onlineType.length<1 || [onlineType isEqualToString:@"offline"]) {
    }else{
        [[UserManager sharedManager] configUserWithLocalData];
        self.nameTextField.text = [user objectForKey:@"userMail"];
        self.passwordTextField.text = [user objectForKey:@"pwd"];
        RootTabbarViewController *rootView = [[RootTabbarViewController alloc] init];
        [self presentViewController:rootView animated:YES completion:nil];
    }
}

@end
