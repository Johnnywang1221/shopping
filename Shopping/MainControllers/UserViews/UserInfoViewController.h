//
//  UserInfoViewController.h
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface UserInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,NetWorkManagerDelegete>

@property (strong,nonatomic) UITableView *mTableview;
@property (strong,nonatomic) UIImageView *displayImage;
@property (nonatomic,retain) UIButton *logoffButton;

@end
