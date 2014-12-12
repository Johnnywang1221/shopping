//
//  MainPersonalViewController.h
//  EducationApp
//
//  Created by Darwin on 14/11/5.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPersonalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) UIButton *headView;
@property (nonatomic,retain) UIButton *qusetionButton;
@property (nonatomic,retain) UIButton *answerButton;
@property (nonatomic,retain) UILabel *qusetionLabel;
@property (nonatomic,retain) UILabel *answerLabel;
@property (nonatomic,retain) UIImageView *userImgView;
@property (nonatomic,retain) UILabel *userNameLabel;
@property (nonatomic,retain) UILabel *userAreaLabel;
@property (nonatomic,retain) UIView *bottomView;
@property (nonatomic,retain) UITableView *userTable;
@property (nonatomic,retain) NSMutableDictionary *userDic;
@property (nonatomic ) BOOL hasLogin;
@property (nonatomic,retain) UIButton *settingButton;

+ (MainPersonalViewController *)shareedViewController;

@end
