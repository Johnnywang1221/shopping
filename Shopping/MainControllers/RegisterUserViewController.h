//
//  RegisterUserViewController.h
//  EducationApp
//
//  Created by Darwin on 14/11/18.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface RegisterUserViewController : UIViewController<UITextFieldDelegate,NetWorkManagerDelegete>

@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) UITextField *nameTextField;
@property (nonatomic,retain) UITextField *emailTextField;
@property (nonatomic,retain) UITextField *passwordTextField;
@property (nonatomic,retain) UITextField *passwordTextField2;

@property (nonatomic,retain) UIButton *registerButton;

@end
