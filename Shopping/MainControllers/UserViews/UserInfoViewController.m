//
//  UserInfoViewController.m
//  FreeNovelReading
//
//  Created by Darwin on 14-4-18.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EditClassViewController.h"
#import "EditNameViewController.h"
#import "EditPasswordViewController.h"
#import "sexViewController.h"
#import "EditSchoolViewController.h"
#import "JSONKit.h"
#import "UserManager.h"
#import "UIImageView+AFNetworking.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        self.title = @"用户信息";
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        
        self.mTableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        self.mTableview.backgroundColor = [UIColor clearColor];
        self.mTableview.delegate = self;
        self.mTableview.dataSource = self;
        self.mTableview.scrollEnabled = NO;
        [self.view addSubview:self.mTableview];
        
        self.displayImage = [[UIImageView alloc] init];
        self.displayImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editUserImg)];
        [self.displayImage addGestureRecognizer:tap];
        
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"userImg.png"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:filePath]) {
            self.displayImage.image = [UIImage imageWithContentsOfFile:filePath];
        }else{
            self.displayImage.image = [UIImage imageNamed:@"defaultUserImg"];
        }
        
        self.displayImage.layer.cornerRadius = 36;
        self.displayImage.layer.borderWidth = 2;
        self.displayImage.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.displayImage.layer.masksToBounds = YES;
        [self.view addSubview:self.displayImage];
        
        self.logoffButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.logoffButton.backgroundColor = [UIColor clearColor];
        [self.logoffButton addTarget:self action:@selector(userLogoff) forControlEvents:UIControlEventTouchUpInside];
        [self.logoffButton setTitle:@"退出登录" forState:UIControlStateNormal];
        self.logoffButton.layer.cornerRadius = 5;
        self.logoffButton.layer.masksToBounds = YES;
        self.logoffButton.backgroundColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
        [self.view addSubview:self.logoffButton];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(reloadView) name:@"UserDataChanged" object:nil];
        
    }
    return self;
}



//设置section的数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//设置每个分区有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

//设置每行调用的cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    UserManager *userManger = [UserManager sharedManager];
    
    if (indexPath.section == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"昵称";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.text = userManger.userName;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
        else if (indexPath.row == 1){
            
            cell.textLabel.text = @"性别";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.text = userManger.userSex;
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
        else if (indexPath.row == 2){
            
            cell.textLabel.text = @"年级";
            cell.textLabel.font = [UIFont systemFontOfSize: 16];
            cell.detailTextLabel.text = userManger.className;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"学校";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.text = userManger.schoolName;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"修改密码";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.55];
    return cell;
}
//选择单元格时候，检测到这一点
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    if (indexPath.section==0){
        if (indexPath.row == 0) {
            EditNameViewController *name = [[EditNameViewController alloc] init];
            [name setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:name animated:YES];
        }else if (indexPath.row == 1){
            sexViewController *sex = [[sexViewController alloc] init];
            [sex setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:sex animated:YES];
        }else if (indexPath.row == 2){
            EditClassViewController *email = [[EditClassViewController alloc] init];
            [email setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:email animated:YES];
        }else if (indexPath.row == 3){
            EditSchoolViewController *phone = [[EditSchoolViewController alloc] init];
            [phone setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:phone animated:YES];
        }else if (indexPath.row == 4){
            EditPasswordViewController *pwd = [[EditPasswordViewController alloc] init];
            [pwd setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:pwd animated:YES];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1;
}

//修改行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//actionsheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString*buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"拍照"]) {
        UIImagePickerController*imagePicker;
        imagePicker =[[UIImagePickerController alloc]init];
        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate =self;
        //使照片可编辑
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if ([buttonTitle isEqualToString:@"从手机相册选择"]){
        
        UIImagePickerController*imagePicker;
        imagePicker =[[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate =self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{

    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"userImg.png"];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    [data writeToFile:filePath atomically:YES];
    self.displayImage.image = [UIImage imageWithContentsOfFile:filePath];
    [self  dismissViewControllerAnimated:YES completion:nil];
}


- (void)editUserImg
{
    UIActionSheet*actionsheet;
    actionsheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionsheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionsheet showInView:self.view];
}


- (void)reloadView
{
    UserManager *userManager = [UserManager sharedManager];
    if ([userManager.onlineType isEqual:@"login"] == NO) {
        [self.displayImage setImageWithURL:[NSURL URLWithString:userManager.imagePath]];
    }else if(userManager.userImage){
        self.displayImage.image = userManager.userImage;
    }else{
        self.displayImage.image = [UIImage imageNamed:@"icon"];
    }
    
    
    self.mTableview.frame = CGRectMake(0, 110, self.view.frame.size.width, 45*5);
    self.displayImage.frame=CGRectMake(0, 22, 72, 72);
    self.displayImage.center = CGPointMake(self.view.center.x, self.displayImage.center.y);
    [self.mTableview reloadData];
    self.logoffButton.frame = CGRectMake(10, self.view.frame.size.height-42, self.view.frame.size.width-20, 40);
    
}

- (void)userLogoff
{
    NetWorkManager *netWork = [[NetWorkManager alloc] init];
    netWork.delegete = self;
    netWork.dataType = @"userlogoff";
    [netWork getDataWithRequestPath:@"/account/mobile/signout" andParameters:@{@"token":[UserManager sharedManager].token}andRequestType:0];
}


- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"userlogoff"]){
        NSDictionary *dic = [responseString objectFromJSONString];
        if ([dic isEqual:[NSNull null]] || [dic isEqual:nil] ||[dic description].length == 6) {
            return;
        }else{
            if (((NSNumber *)[dic objectForKey:@"type"]).intValue == 1) {
                [self.navigationController.tabBarController dismissViewControllerAnimated:YES completion:nil];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:@"offline" forKey:@"onlineType"];
                [user synchronize];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求失败" message:[dic objectForKey:@"error"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self reloadView];
}

@end
