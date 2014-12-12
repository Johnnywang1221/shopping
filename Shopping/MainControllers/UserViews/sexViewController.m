//
//  sexViewController.m
//  LHZT78
//
//  Created by apple on 13-10-12.
//  Copyright (c) 2013年 feiyu. All rights reserved.
//

#import "sexViewController.h"
#import "UserManager.h"
#import "JSONKit.h"

@interface sexViewController ()

@end

@implementation sexViewController
@synthesize mtableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"修改性别";
        // Custom initialization
        [self.navigationItem setRightBarButtonItem:
         [[UIBarButtonItem alloc] initWithTitle:@"保存"  style:UIBarButtonItemStylePlain target:self action:@selector(submmit)]];
        self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return self;
}


- (void)submmit
{
    NetWorkManager *netWork = [[NetWorkManager alloc] init];
    netWork.delegete = self;
    netWork.dataType = @"user_updateSex";
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.selectedSex forKey:@"user_sex"];
    [dic setObject:[UserManager sharedManager].token forKey:@"token"];
    [netWork getDataWithRequestPath:@"/user/mobile/change_pwd" andParameters:dic andRequestType:0];
    [netWork getDataWithRequestPath:@"http://115.28.234.30:8080/ajax" andParameters:dic andRequestType:0];
}

- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"user_updateSex"]) {
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


- (void)viewDidLoad
{
    mtableView.backgroundView = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [super viewDidLoad];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserManager *userManager = [UserManager sharedManager];
    NSString *sex = userManager.userSex;
    self.selectedSex = sex;
    static NSString *CellIdentifier=@"cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        
        UILabel*label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 13, 80, 20)];
       label1.text = @"男";
        if ([label1.text isEqualToString:sex]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
       label1.backgroundColor = [UIColor clearColor];
       label1.font = [UIFont fontWithName:@"Arial" size:16];
       [cell addSubview:label1];
        
    }
    else if (indexPath.section == 1)
    {
        UILabel*label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 13, 80, 20)];
        label1.text = @"女";
        if ([label1.text isEqualToString:sex]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont fontWithName:@"Arial" size:16];
        [cell addSubview:label1];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedSex = @"男";
    }
    else if (indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedSex = @"女";
    }
    
}
@end
