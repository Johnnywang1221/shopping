//
//  EditSchoolViewController.h
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface EditSchoolViewController : UIViewController<UITextFieldDelegate,NetWorkManagerDelegete>

@property (nonatomic,retain) UITextField *schoolTextView;
@property (nonatomic,retain) UITextField *passwordTextView;

@end
