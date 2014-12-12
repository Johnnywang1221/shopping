//
//  EditSchoolViewController.m
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "EditSchoolViewController.h"
#import "JSONKit.h"
#import "UserManager.h"

@interface EditSchoolViewController ()

@end

@implementation EditSchoolViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改学校";
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
        lb1.text = @"学校:";
        [self.view addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 55, 50, 30)];
        lb2.backgroundColor = [UIColor clearColor];
        lb2.textColor = [UIColor blackColor];
        lb2.font = [UIFont systemFontOfSize:14];
        lb2.textAlignment = NSTextAlignmentRight;
        lb2.text = @"密码:";
        //[self.view addSubview:lb2];
        
        self.schoolTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 10+20, 200, 30)];
        self.schoolTextView.textColor = [UIColor darkGrayColor];
        self.schoolTextView.placeholder = @"请输入学校";
        self.schoolTextView.delegate = self;
        self.schoolTextView.tag = 111;
        self.schoolTextView.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.schoolTextView.font = [UIFont systemFontOfSize:14];
        self.schoolTextView.returnKeyType = UIReturnKeyDone;
        self.schoolTextView.backgroundColor = [UIColor whiteColor];
        self.schoolTextView.borderStyle = UITextBorderStyleRoundedRect;
        self.schoolTextView.clearButtonMode =UITextFieldViewModeAlways;
        self.schoolTextView.keyboardType = UIKeyboardTypeDefault;
        [self.view addSubview:self.schoolTextView];
        
        self.passwordTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 55, 200, 30)];
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
    self.schoolTextView.text = userManager.schoolName;
}

- (void)submmit
{
    if (self.schoolTextView.text.length <1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的学校不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        NetWorkManager *netWork = [[NetWorkManager alloc] init];
        netWork.delegete = self;
        netWork.dataType = @"user_updateSchool";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[UserManager sharedManager].token forKey:@"token"];
        [dic setObject:self.schoolTextView.text forKey:@"school"];
        [dic setObject:self.passwordTextView.text forKey:@"pwd"];
        [netWork getDataWithRequestPath:@"/user/mobile/change_pwd" andParameters:dic andRequestType:0];
    }
}


- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"user_updateSchool"]) {
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


- (BOOL)checkTel:(NSString *)str
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

- (void)hideKeyBoard
{
    [self.schoolTextView resignFirstResponder];
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
