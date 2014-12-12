//
//  EditNameViewController.h
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface EditNameViewController : UIViewController<UITextFieldDelegate,NetWorkManagerDelegete>

@property (nonatomic,retain) UITextField *nameTextView;
@property (nonatomic,retain) UITextField *passwordTextView;
@property (nonatomic,retain) UIButton *submitButton;

@end
