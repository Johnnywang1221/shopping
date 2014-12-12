//
//  UserManager.h
//  EducationApp
//
//  Created by Darwin on 14/11/24.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface UserManager : NSObject <NetWorkManagerDelegete>

@property (nonatomic) BOOL isOnline;
@property (nonatomic,retain) NSString *onlineType;
@property (nonatomic,retain) NSMutableDictionary *sinaUserDic;
@property (nonatomic,retain) NSMutableDictionary *qqUserDic;
@property (nonatomic,retain) NSMutableDictionary *weichatUserDic;
@property (nonatomic,retain) NSMutableDictionary *normalUserDic;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *userMail;
@property (nonatomic,retain) NSString *userID;
@property (nonatomic,retain) NSString *schoolName;
@property (nonatomic,retain) NSString *className;
@property (nonatomic,retain) NSString *userSex;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *imagePath;
@property (nonatomic,retain) NSString *token;

@property (nonatomic,retain) NSString *selectedClass;
@property (nonatomic,retain) NSString *selectedSubject;

@property (nonatomic,retain) UIImage *userImage;
@property (nonatomic) int questionCount;
@property (nonatomic) int answerCount;
@property (nonatomic,retain) NSMutableDictionary *myFriends;


+ (UserManager *)sharedManager;
- (void)freshUserData;
- (void)configUser;
- (void)configUserWithLocalData;
- (BOOL)checkFriend;

@end
