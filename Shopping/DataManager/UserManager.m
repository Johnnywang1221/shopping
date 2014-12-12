//
//  UserManager.m
//  EducationApp
//
//  Created by Darwin on 14/11/24.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import "UserManager.h"
#import "JSONKit.h"

static UserManager *manager;
@implementation UserManager

+ (UserManager *)sharedManager{
    if (manager == nil) {
        manager = [[UserManager alloc] init];
        
    }
    return manager;
}


- (void)configUser{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user synchronize];
}

- (void)configUserWithLocalData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.imagePath = [user objectForKey:@"imagePath"];
    self.onlineType = [user objectForKey:@"onlineType"];
    if ([self.onlineType isEqual:@"qq"]) {
        self.qqUserDic = [user objectForKey:@"qqUserDic"];
    }else if ([self.onlineType isEqual:@"sina"]){
        self.sinaUserDic = [user objectForKey:@"sinaUserDic"];
        self.userName = [self.sinaUserDic objectForKey:@"username"];
        self.imagePath = [self.sinaUserDic objectForKey:@"icon"];
    }else if ([self.onlineType isEqual:@"wechat"]){
        self.weichatUserDic = [user objectForKey:@"weichatUserDic"];
    }
    if (self.userName.length<1) {
        self.userName = @"手机用户";
    }
    self.userID = [user objectForKey:@"userID"];
    self.userSex = [user objectForKey:@"userSex"];
    self.schoolName = [user objectForKey:@"schoolName"];
    self.className = [user objectForKey:@"className"];
    self.questionCount = ((NSNumber *)[user objectForKey:@"questionCount"]).intValue;
    self.answerCount = ((NSNumber *)[user objectForKey:@"answerCount"]).intValue;
    self.userImage = [UIImage imageNamed:@"defaultUserImg"];
    self.token = [user objectForKey:@"token"];
    
}


- (void)freshUserData{
    NetWorkManager *network = [[NetWorkManager alloc] init];
    network.delegete = self;
    network.dataType = @"getUserInfo";
    [network getDataWithRequestPath:@"" andParameters:@{} andRequestType:0];
    
}


- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network{
    NSString *responseString = [[NSString alloc] initWithData:network.respondData encoding:NSUTF8StringEncoding];
    if ([responseString isEqual:[NSNull null]] || [responseString isEqual:nil] || responseString.length==0 || responseString.description.length == 6) {
        return;
    }
    if ([network.dataType isEqualToString:@"getUserInfo"]) {
        NSDictionary *dic = [responseString objectFromJSONString];
        NSLog(@"%@",dic);
    }
    [self configUser];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"UserDataChanged" object:self userInfo:nil];
}


- (BOOL)checkFriend{
    return NO;
}

@end
