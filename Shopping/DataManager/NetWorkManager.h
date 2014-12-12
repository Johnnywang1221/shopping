//
//  NetWork.h
//  EnglishLearning
//
//  Created by LHZT on 13-10-26.
//  Copyright (c) 2013年 LHZT. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WaitDataView.h"


@class NetWorkManager;

@protocol NetWorkManagerDelegete <NSObject>

- (void)dealWithReturnedDataWithNetWork:(NetWorkManager *)network;

@end

@interface NetWorkManager : NSObject<UIAlertViewDelegate>

@property (nonatomic,retain) NSString *ulrPath;
@property (nonatomic,retain) NSObject <NetWorkManagerDelegete> *delegete;
@property (nonatomic,retain) NSData *respondData;
@property (nonatomic,retain) NSString *dataType;

+ (BOOL)checkNet;
+ (BOOL)checkWifi;
- (void)getDataWithRequestPath:(NSString *) requestPath andParameters:(NSDictionary *)params andRequestType:(int)type;

@end
