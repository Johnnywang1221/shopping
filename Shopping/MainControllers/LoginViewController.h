//
//  LoginViewController.h
//  EducationApp
//
//  Created by Darwin on 14/11/17.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "UMSocial.h"
#import "UserManager.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "NetWorkManager.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UMSocialUIDelegate,NetWorkManagerDelegete>

@property (nonatomic,retain) UIButton *qqButton;
@property (nonatomic,retain) UIButton *sinaButton;
@property (nonatomic,retain) UIButton *wechatButton;

@property (nonatomic,retain) UITextField *nameTextField;
@property (nonatomic,retain) UITextField *passwordTextField;
@property (nonatomic,retain) UIButton *loginButton;
@property (nonatomic,retain) UIButton *registerButton;



@end
