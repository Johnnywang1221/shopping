//
//  EditPasswordViewController.m
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "UserManager.h"
#import "JSONKit.h"

@interface EditPasswordViewController ()

@end

@implementation EditPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改密码";
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
        lb1.text = @"旧密码:";
        [self.view addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 55+22, 50, 30)];
        lb2.backgroundColor = [UIColor clearColor];
        lb2.textColor = [UIColor blackColor];
        lb2.font = [UIFont systemFontOfSize:14];
        lb2.textAlignment = NSTextAlignmentRight;
        lb2.text = @"新密码:";
        [self.view addSubview:lb2];
        
        UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(25, 100+22, 50, 30)];
        lb3.backgroundColor = [UIColor clearColor];
        lb3.textColor = [UIColor blackColor];
        lb3.font = [UIFont systemFontOfSize:14];
        lb3.textAlignment = NSTextAlignmentRight;
        lb3.text = @"确认:";
        [self.view addSubview:lb3];
        
        self.oldPasswordTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 10+20, 200, 30)];
        self.oldPasswordTextView.textColor = [UIColor darkGrayColor];
        self.oldPasswordTextView.placeholder = @"请输入旧的密码";
        self.oldPasswordTextView.delegate = self;
        self.oldPasswordTextView.tag = 111;
        self.oldPasswordTextView.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.oldPasswordTextView.font = [UIFont systemFontOfSize:14];
        self.oldPasswordTextView.secureTextEntry = YES;
        self.oldPasswordTextView.returnKeyType = UIReturnKeyDone;
        self.oldPasswordTextView.backgroundColor = [UIColor whiteColor];
        self.oldPasswordTextView.borderStyle = UITextBorderStyleRoundedRect;
        self.oldPasswordTextView.clearButtonMode =UITextFieldViewModeAlways;
        self.oldPasswordTextView.keyboardType = UIKeyboardTypeDefault;
        [self.view addSubview:self.oldPasswordTextView];
        
        self.passwordTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 55+20, 200, 30)];
        self.passwordTextView.textColor = [UIColor darkGrayColor];
        self.passwordTextView.placeholder = @"请输入新的密码";
        self.passwordTextView.delegate = self;
        self.passwordTextView.secureTextEntry = YES;
        self.passwordTextView.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.passwordTextView.font = [UIFont systemFontOfSize:14];
        self.passwordTextView.returnKeyType = UIReturnKeyDone;
        self.passwordTextView.tag = 222;
        self.passwordTextView.backgroundColor = [UIColor whiteColor];
        self.passwordTextView.borderStyle = UITextBorderStyleRoundedRect;
        self.passwordTextView.clearButtonMode =UITextFieldViewModeAlways;
        self.passwordTextView.keyboardType = UIKeyboardTypeDefault;
        [self.view addSubview:self.passwordTextView];
        
        self.passwordTextView2 = [[UITextField alloc] initWithFrame:CGRectMake(90, 100+20, 200, 30)];
        self.passwordTextView2.textColor = [UIColor darkGrayColor];
        self.passwordTextView2.placeholder = @"再次输入密码";
        self.passwordTextView2.delegate = self;
        self.passwordTextView2.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.passwordTextView2.font = [UIFont systemFontOfSize:14];
        self.passwordTextView2.returnKeyType = UIReturnKeyDone;
        self.passwordTextView2.secureTextEntry = YES;
        self.passwordTextView2.tag = 333;
        self.passwordTextView2.backgroundColor = [UIColor whiteColor];
        self.passwordTextView2.borderStyle = UITextBorderStyleRoundedRect;
        self.passwordTextView2.clearButtonMode =UITextFieldViewModeAlways;
        self.passwordTextView2.keyboardType = UIKeyboardTypeDefault;
        [self.view addSubview:self.passwordTextView2];
    }
    return self;
}

- (void)submmit
{
    if (self.passwordTextView.text.length <1 || self.passwordTextView2.text.length<1 || self.oldPasswordTextView.text.length<1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else if([self.passwordTextView2.text isEqualToString:self.passwordTextView.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您两次输入的新密码不同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        NetWorkManager *netWork = [[NetWorkManager alloc] init];
        netWork.delegete = self;
        netWork.dataType = @"user_updatePassword";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[UserManager sharedManager].token forKey:@"token"];
        [dic setObject:self.oldPasswordTextView.text forKey:@"old_pwd"];
        [dic setObject:self.passwordTextView.text forKey:@"new_pwd"];
        [netWork getDataWithRequestPath:@"/user/mobile/change_pwd" andParameters:dic andRequestType:0];
    }
}

- (void)hideKeyBoard
{
    [self.oldPasswordTextView resignFirstResponder];
    [self.passwordTextView resignFirstResponder];
    [self.passwordTextView2 resignFirstResponder];
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


- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"user_updatePassword"]) {
        NSDictionary *dic = [responseString objectFromJSONString];
        if (((NSString *)[dic objectForKey:@"type"]).intValue == 1) {
            
            UserManager *userManager = [UserManager sharedManager];
            [userManager freshUserData];

            [self.navigationController popViewControllerAnimated:YES];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:((NSString *)[dic objectForKey:@"error"]) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    
}

@end
