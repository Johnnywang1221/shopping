//
//  MainPersonalViewController.m
//  EducationApp
//
//  Created by Darwin on 14/11/5.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import "MainPersonalViewController.h"
#import "JSONKit.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMFeedbackViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UserInfoViewController.h"
#import "UserManager.h"

@interface MainPersonalViewController ()

@end

static MainPersonalViewController *sharedController;

@implementation MainPersonalViewController


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


+ (MainPersonalViewController *)shareedViewController{
    if (sharedController == nil) {
        sharedController = [[MainPersonalViewController alloc] init];
    }
    return sharedController;
}



- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.hasLogin = YES;
        self.title = @"用户中心";
        if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.delegate = self;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.scrollView];
        
        self.headView = [[UIButton alloc] init];
        self.headView.backgroundColor = [UIColor colorWithRed:204/246.0 green:228/255.0 blue:229/255.0 alpha:1];
        //[self.headView addTarget:self action:@selector(userLogIn) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.headView];
        
        self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.settingButton.backgroundColor = [UIColor clearColor];
        [self.settingButton addTarget:self action:@selector(userSetting) forControlEvents:UIControlEventTouchUpInside];
        self.settingButton.frame = CGRectMake(self.view.frame.size.width-40, 12, 28, 28);
        [self.settingButton setBackgroundImage:[UIImage imageNamed:@"userSetting"] forState:UIControlStateNormal];
        [self.headView addSubview:self.settingButton];
        
        self.userImgView = [[UIImageView alloc] init];
        self.userImgView.frame = CGRectMake(25, 25, 64, 64);
        self.userImgView.layer.cornerRadius = 32;
        self.userImgView.layer.borderWidth = 2;
        self.userImgView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.userImgView.backgroundColor = [UIColor whiteColor];
        self.userImgView.layer.masksToBounds = YES;
        [self.headView addSubview:self.userImgView];
        
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.textColor = [UIColor blackColor];
        self.userNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.userNameLabel setBackgroundColor:[UIColor clearColor]];
        self.userNameLabel.font = [UIFont boldSystemFontOfSize:15];
        self.userNameLabel.frame = CGRectMake(100, 32, 200, 20);
        [self.headView addSubview:self.userNameLabel];
        
        self.userAreaLabel = [[UILabel alloc] init];
        self.userAreaLabel.textColor = [UIColor blackColor];
        self.userAreaLabel.textAlignment = NSTextAlignmentLeft;
        [self.userAreaLabel setBackgroundColor:[UIColor clearColor]];
        self.userAreaLabel.font = [UIFont boldSystemFontOfSize:15];
        self.userAreaLabel.frame = CGRectMake(100, 62, 200, 20);
        [self.headView addSubview:self.userAreaLabel];
        
        self.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
        UIView *headBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, 40)];
        headBottomView.backgroundColor = [UIColor whiteColor];
        headBottomView.userInteractionEnabled = YES;
        [self.headView addSubview:headBottomView];
        self.qusetionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.qusetionButton.backgroundColor = [UIColor clearColor];
        [self.qusetionButton addTarget:self action:@selector(addQuestion) forControlEvents:UIControlEventTouchUpInside];
        self.qusetionButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 40);
        [headBottomView addSubview:self.qusetionButton];
        
        self.answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.answerButton.backgroundColor = [UIColor clearColor];
        [self.answerButton addTarget:self action:@selector(addAnswer) forControlEvents:UIControlEventTouchUpInside];
        self.answerButton.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40);
        [headBottomView addSubview:self.answerButton];
        
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4-40, 10, 38, 20)];
        lb1.backgroundColor = [UIColor clearColor];
        lb1.font = [UIFont boldSystemFontOfSize:15];
        lb1.textAlignment = NSTextAlignmentRight;
        lb1.text = @"提问";
        [self.qusetionButton addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4-40, 10, 38, 20)];
        lb2.backgroundColor = [UIColor clearColor];
        lb2.textAlignment = NSTextAlignmentRight;
        lb2.font = [UIFont boldSystemFontOfSize:15];
        lb2.text = @"回答";
        [self.answerButton addSubview:lb2];
        
        self.qusetionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4+2, 10, 40, 20)];
        self.qusetionLabel.backgroundColor = [UIColor clearColor];
        self.qusetionLabel.font = [UIFont boldSystemFontOfSize:16];
        self.qusetionLabel.textColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
        [self.qusetionButton addSubview:self.qusetionLabel];
        
        self.answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4+2, 10, 40, 20)];
        self.answerLabel.backgroundColor = [UIColor clearColor];
        self.answerLabel.font = [UIFont boldSystemFontOfSize:16];
        self.answerLabel.textColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
        [self.answerButton addSubview:self.answerLabel];
        
        UIView *hr = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-1, 4, 2, 32)];
        hr.backgroundColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
        [headBottomView addSubview:hr];
        

        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = [UIColor clearColor];
        self.bottomView.layer.cornerRadius = 0;
        [self.scrollView addSubview:self.bottomView];
        self.userTable = [[UITableView alloc] initWithFrame:CGRectMake(0,10, self.view.frame.size.width-20, 250) style:UITableViewStylePlain];
        self.userTable.backgroundColor = [UIColor clearColor];
        self.userTable.backgroundView = nil;
        self.userTable.delegate = self;
        self.userTable.dataSource = self;
        self.userTable.scrollEnabled = NO;
        [self.bottomView addSubview:self.userTable];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(userDataChanged) name:@"UserDataChanged" object:nil];
        
        self.userImgView.userInteractionEnabled = YES;
        [self.view bringSubviewToFront:self.userImgView];
        [self.userImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImage)]];
        
    }
    return self;
}



- (void)userDataChanged{
    UserManager *userManager = [UserManager sharedManager];
    if ([userManager.onlineType isEqual:@"login"] == NO) {
        [self.userImgView setImageWithURL:[NSURL URLWithString:userManager.imagePath] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    }else if(userManager.userImage){
        self.userImgView.image = userManager.userImage;
    }else{
        self.userImgView.image = [UIImage imageNamed:@"icon"];
    }
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@   %@",userManager.userName,userManager.userSex];
    self.userAreaLabel.text = [NSString stringWithFormat:@"%@  |  %@",userManager.schoolName,userManager.className];
    self.qusetionLabel.text = [NSString stringWithFormat:@"%d",userManager.questionCount];
    self.answerLabel.text = [NSString stringWithFormat:@"%d",userManager.answerCount];
}

- (void)addQuestion{
    
}

- (void)addAnswer{
    
}

- (void)userSetting{
    UserInfoViewController *settingView = [[UserInfoViewController alloc] init];
    [settingView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingView animated:YES];
            
}


//actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [actionSheet resignFirstResponder];
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (actionSheet.tag == 100) {
        NSString*buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([buttonTitle isEqualToString:@"使用QQ账号登陆"]) {
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                          {
                                              self.userDic = [NSMutableDictionary dictionaryWithDictionary:[response.data objectForKey:@"tencent"]];
                                              [self.userImgView setImageWithURL:[NSURL URLWithString:[self.userDic objectForKey:@"defaultUserImg"]] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
                                              self.userNameLabel.text = [self.userDic objectForKey:@"username"];
                                              [self.userDic setObject:@"tencent" forKey:@"loginType"];

                                              
                                              NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                              [userDefaults setObject:[self.userDic JSONString] forKey:@"userDic"];
                                              [userDefaults synchronize];
                                              
                                              self.hasLogin = YES;
                                              [self.userTable reloadData];
                                          });
        }
        else if ([buttonTitle isEqualToString:@"使用新浪微博账号登陆"]){
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                          {
                                              self.userDic = [NSMutableDictionary dictionaryWithDictionary:[response.data objectForKey:@"sina"]];
                                              [self.userImgView setImageWithURL:[NSURL URLWithString:[self.userDic objectForKey:@"defaultUserImg"]] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
                                              self.userNameLabel.text = [self.userDic objectForKey:@"username"];
                                              [self.userDic setObject:@"sina" forKey:@"loginType"];
                                              
                                              NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                              [userDefaults setObject:[self.userDic JSONString] forKey:@"userDic"];
                                              [userDefaults synchronize];
                                              
                                              self.hasLogin = YES;
                                              [self.userTable reloadData];
                                          });
        }
        
    }else if (actionSheet.tag == 200){
        NSString*buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([buttonTitle isEqualToString:@"退出"]) {
            self.hasLogin = NO;
            self.userDic = nil;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"userDic"];
            [userDefaults synchronize];
            self.userNameLabel.text = @"尚未登陆";
            self.userImgView.image = [UIImage imageNamed:@"defaultUserImg"];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.hasLogin){
        return 3;
    }
    else
        return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (self.hasLogin) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"我的好友"];
            
        }else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"给个好评"];
        }else if (indexPath.row == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"邀请好友"];
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"给个好评"];
        }else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"邀请好友"];
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    if (self.hasLogin) {
        if(indexPath.row == 0){
        }
        if(indexPath.row == 1)
        {
            if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
                NSString *str = [NSString stringWithFormat:
                                 
                                 @"itms-apps://itunes.apple.com/app/id%@",@"913811788"];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                NSString *str = [NSString stringWithFormat:
                                 @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",913811788];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }else if (indexPath.row == 2){
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"53fef6b2fd98c50314009e2f"
                                              shareText:@"快看神器，最全的手机小说阅读助手；秒级发现最新章节，最好用的追书神器；智能汇集多家著名小说站排名榜单，为您推荐最火爆的小说。赶快来试试吧！QQ用户群：228334013 下载地址：https://itunes.apple.com/us/app/kuai-bo-shen-qi/id913811788?l=zh&ls=1&mt=8"
                                             shareImage:[UIImage imageNamed:@"icon_share"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil]
                                               delegate:nil];
        }
        else if (indexPath.row == 3){
            [self showNativeFeedbackWithAppkey:@"53fef6b2fd98c50314009e2f"];
        }
    }else {
        if(indexPath.row == 0)
        {
            if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
                NSString *str = [NSString stringWithFormat:
                                 
                                 @"itms-apps://itunes.apple.com/app/id%@",@"913811788"];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                NSString *str = [NSString stringWithFormat:
                                 @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",913811788];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }else if (indexPath.row == 1){
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"53fef6b2fd98c50314009e2f"
                                              shareText:@"快看神器，最全的手机小说阅读助手；秒级发现最新章节，最好用的追书神器；智能汇集多家著名小说站排名榜单，为您推荐最火爆的小说。赶快来试试吧！QQ用户群：228334013 下载地址：https://itunes.apple.com/us/app/kuai-bo-shen-qi/id913811788?l=zh&ls=1&mt=8"
                                             shareImage:[UIImage imageNamed:@"icon_share"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,nil]
                                               delegate:nil];
        }
        else if (indexPath.row == 2){
            [self showNativeFeedbackWithAppkey:@"53fef6b2fd98c50314009e2f"];
        }
    }
}



- (void)showNativeFeedbackWithAppkey:(NSString *)appkey {
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
        feedbackViewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    feedbackViewController.appkey = appkey;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentViewController:navigationController  animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (void)viewDidAppear:(BOOL)animated{
    UserManager *userManager = [UserManager sharedManager];
    if ([userManager.onlineType isEqual:@"login"] == NO) {
        [self.userImgView setImageWithURL:[NSURL URLWithString:userManager.imagePath] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    }else if(userManager.userImage){
        self.userImgView.image = userManager.userImage;
    }else{
        self.userImgView.image = [UIImage imageNamed:@"icon"];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    UserManager *userManager = [UserManager sharedManager];
    if ([userManager.onlineType isEqual:@"login"] == NO) {
        [self.userImgView setImageWithURL:[NSURL URLWithString:userManager.imagePath] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    }else if(userManager.userImage){
        self.userImgView.image = userManager.userImage;
    }else{
        self.userImgView.image = [UIImage imageNamed:@"icon"];
    }
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@   %@",userManager.userName,userManager.userSex];
    self.userAreaLabel.text = [NSString stringWithFormat:@"%@  |  %@",userManager.schoolName,userManager.className];
    self.qusetionLabel.text = [NSString stringWithFormat:@"%d",userManager.questionCount];
    self.answerLabel.text = [NSString stringWithFormat:@"%d",userManager.answerCount];
    
    [self.navigationController setNavigationBarHidden:NO];
    int viewHeight = [UIScreen mainScreen].bounds.size.height-64;
    int viewWidth = self.view.frame.size.width;
    self.scrollView.frame = CGRectMake(0,0, viewWidth, viewHeight);
    
    if (self.hasLogin) {
        self.bottomView.frame = CGRectMake(0, 165, viewWidth, 45*4-2);
        self.userTable.frame = CGRectMake(0,0, viewWidth, 45*4-2);
    }else{
        self.bottomView.frame = CGRectMake(0, 165, viewWidth, 45*3-2);
        self.userTable.frame = CGRectMake(0,0, viewWidth, 45*3-2);
    }
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width,self.bottomView.frame.origin.y+self.bottomView.frame.size.height+10);
    [self.scrollView setContentSize:newSize];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"userImg.png"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        self.userImgView.image = [UIImage imageWithContentsOfFile:filePath];
    }else self.userImgView.image = [UIImage imageNamed:@"defaultUserImg"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userDic = [[userDefaults objectForKey:@"userDic"] objectFromJSONString];
//    if (self.userDic) {
//        self.hasLogin = YES;
//        [self.userImgView setImageWithURL:[NSURL URLWithString:[self.userDic objectForKey:@"defaultUserImg"]]];
//        self.userNameLabel.text = [self.userDic objectForKey:@"username"];
//    }else {
//        self.hasLogin = NO;
//        self.userNameLabel.text = @"尚未登陆";
//    }

    
    [self.userTable reloadData];
    
}



- (void)tapUserImage{
    
}


@end
