//
//  EditClassViewController.h
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface EditClassViewController : UIViewController<UITextFieldDelegate,NetWorkManagerDelegete,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *pickerArray;
}

@property (nonatomic,retain) UIPickerView *classPickerView;
@property (nonatomic,retain) UITextField *passwordTextView;
@property (nonatomic,retain) NSString *selectedClass;

@end
