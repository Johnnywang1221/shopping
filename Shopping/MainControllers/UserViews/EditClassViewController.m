//
//  EditClassViewController.m
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "EditClassViewController.h"
#import "JSONKit.h"
#import "UserManager.h"

@interface EditClassViewController ()

@end

@implementation EditClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改年级";
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
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 55+20, 50, 30)];
        lb2.backgroundColor = [UIColor blackColor];
        lb2.textColor = [UIColor blackColor];
        lb2.font = [UIFont systemFontOfSize:14];
        lb2.textAlignment = NSTextAlignmentRight;
        lb2.text = @"密码:";
        //[self.view addSubview:lb2];
        
        self.classPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 10+20, 320, 250)];
        pickerArray = [NSArray arrayWithObjects:@"小学",@"初中一年级",@"初中二年级",@"初中三年级",@"高中一年级",@"高中二年级",@"高中三年级",@"保密", nil];
        
        self.classPickerView.delegate = self;
        self.classPickerView.dataSource = self;
        [self.classPickerView reloadAllComponents];
        [self.view addSubview:self.classPickerView];
        
        self.passwordTextView = [[UITextField alloc] initWithFrame:CGRectMake(90, 55+20, 200, 30)];
        self.passwordTextView.textColor = [UIColor darkGrayColor];
        self.passwordTextView.placeholder = @"在此输入密码";
        self.passwordTextView.delegate = self;
        self.passwordTextView.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.passwordTextView.font = [UIFont systemFontOfSize:14];
        self.passwordTextView.secureTextEntry = YES;
        self.passwordTextView.returnKeyType = UIReturnKeyDone;
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
    int j = pickerArray.count;
    int i = 7;
    NSString *className = nil;
    for (i=0; i<j; i++) {
        className = [pickerArray objectAtIndex:i];
        if (className.length <= 2) {
            if ([userManager.className isEqualToString:className]) {
                self.selectedClass = className;
                break;
            }
        }else{
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[className substringToIndex:1],[[className substringFromIndex:2] substringToIndex:1]]);
            if ([userManager.className isEqualToString:[NSString stringWithFormat:@"%@%@",[className substringToIndex:1],[[className substringFromIndex:2] substringToIndex:1]]]) {
                self.selectedClass = [className substringToIndex:1],[[className substringFromIndex:2] substringToIndex:1];
                break;
            }
        }
    }
    if (i == 8) {
        i = 7;
    }
    
    [self.classPickerView selectRow:i inComponent:0 animated:YES];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}




- (void)submmit
{
    NetWorkManager *netWork = [[NetWorkManager alloc] init];
    netWork.delegete = self;
    netWork.dataType = @"user_updateClass";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.selectedClass forKey:@"class"];
    [dic setObject:[UserManager sharedManager].token forKey:@"token"];
    [dic setObject:self.passwordTextView.text forKey:@"pwd"];
    [netWork getDataWithRequestPath:@"/user/mobile/change_pwd" andParameters:dic andRequestType:0];
    [netWork getDataWithRequestPath:@"http://115.28.234.30:8080/ajax" andParameters:dic andRequestType:0];
    
}


- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"user_updateClass"]) {
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

//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


@end
