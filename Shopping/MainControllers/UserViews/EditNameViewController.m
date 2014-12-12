//
//  EditNameViewController.m
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "EditNameViewController.h"
#import "JSONKit.h"
#import "UserManager.h"

@interface EditNameViewController ()

@end

@implementation EditNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改昵称";
        if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];

        [self.navigationItem setRightBarButtonItem:
         [[UIBarButtonItem alloc] initWithTitle:@"保存"  style:UIBarButtonItemStylePlain target:self action:@selector(submmit)]];
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bgButton.frame = self.view.frame;
        [bgButton addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bgButton];
        
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 10+22, 50, 30)];
        lb1.backgroundColor = [UIColor clearColor];
        lb1.textColor = [UIColor blackColor];
        lb1.font = [UIFont systemFontOfSize:14];
        lb1.textAlignment = NSTextAlignmentRight;
        lb1.text = @"昵称:";
        [self.view addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 55+22, 50, 30)];
        lb2.backgroundColor = [UIColor clearColor];
        lb2.textColor = [UIColor blackColor];
        lb2.font = [UIFont systemFontOfSize:14];
        lb2.textAlignment = NSTextAlignmentRight;
        lb2.text = @"密码:";
        //[self.view addSubview:lb2];
        
        self.nameTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 10+20, 200, 30)];
        self.nameTextView.textColor = [UIColor darkGrayColor];
        self.nameTextView.placeholder = @"请输入新的昵称";
        self.nameTextView.delegate = self;
        self.nameTextView.tag = 111;
        self.nameTextView.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.nameTextView.font = [UIFont systemFontOfSize:14];
        self.nameTextView.returnKeyType = UIReturnKeyDone;
        self.nameTextView.backgroundColor = [UIColor whiteColor];
        self.nameTextView.borderStyle = UITextBorderStyleRoundedRect;
        self.nameTextView.clearButtonMode =UITextFieldViewModeAlways;
        self.nameTextView.keyboardType = UIKeyboardTypeDefault;
        [self.view addSubview:self.nameTextView];
        
        
        self.passwordTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 55+20, 200, 30)];
        self.passwordTextView.textColor = [UIColor darkGrayColor];
        self.passwordTextView.placeholder = @"在此输入密码";
        self.passwordTextView.delegate = self;
        self.passwordTextView.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.passwordTextView.font = [UIFont systemFontOfSize:14];
        self.passwordTextView.returnKeyType = UIReturnKeyDone;
        self.passwordTextView.secureTextEntry = YES;
        self.passwordTextView.tag = 222;
        self.passwordTextView.backgroundColor = [UIColor clearColor];
        self.passwordTextView.borderStyle = UITextBorderStyleRoundedRect;
        self.passwordTextView.clearButtonMode =UITextFieldViewModeAlways;
        self.passwordTextView.keyboardType = UIKeyboardTypeDefault;
        //[self.view addSubview:self.passwordTextView];
        
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated{
    UserManager *userManager = [UserManager sharedManager];
    self.nameTextView.text = userManager.userName;
}

- (void)submmit
{
    if (self.nameTextView.text.length <1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的昵称不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if(self.nameTextView.text.length >32){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的昵称长度必须小于32个字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
//    }else if([self.passwordTextView.text isEqualToString:[[UserManager getSingleManager].currentUserDic objectForKey:@"pwd"]] == NO){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的密码错误，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
    }else{
        NetWorkManager *netWork = [[NetWorkManager alloc] init];
        netWork.delegete = self;
        netWork.dataType = @"user_updateName";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[UserManager sharedManager].token forKey:@"token"];
        [dic setObject:self.nameTextView.text forKey:@"school"];
        [dic setObject:self.passwordTextView.text forKey:@"pwd"];
        [netWork getDataWithRequestPath:@"/user/mobile/change_pwd" andParameters:dic andRequestType:0];
    }
}



- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"user_updateName"]) {
        NSDictionary *dic = [responseString objectFromJSONString];
        NSLog(@"%@",dic);
        
        if (((NSString *)[dic objectForKey:@"ret_code"]).intValue == 0) {
            
            UserManager *userManager = [UserManager sharedManager];
            [userManager freshUserData];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if(((NSString *)[dic objectForKey:@"ret_code"]).intValue == -2){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"修改失败，因为该用户不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"修改失败,请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
}


- (void)hideKeyBoard
{
    [self.nameTextView resignFirstResponder];
    [self.passwordTextView resignFirstResponder];
    
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


@end
