//
//  NetWork.m
//  EnglishLearning
//
//  Created by LHZT on 13-10-26.
//  Copyright (c) 2013年 LHZT. All rights reserved.
//

#import "NetWorkManager.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "ASIFormDataRequest.h"

@implementation NetWorkManager
@synthesize ulrPath,respondData;

+ (BOOL)checkNet
{
    BOOL isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    if (!isExistenceNetwork) {
        return NO;
    }
    return YES;
}

+ (BOOL)checkWifi
{
    BOOL isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = NO;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    if (!isExistenceNetwork) {
        return NO;
    }
    return YES;
}

- (void)getDataWithRequestPath:(NSString *) requestPath andParameters:(NSDictionary *)params andRequestType:(int)type
{
    if ([NetWorkManager checkNet]) {
        Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        if ([r currentReachabilityStatus] != NotReachable) {
            ulrPath = @"http://www.tuomeng.com.cn";
            NSString *path = [NSString stringWithFormat:@"%@%@",ulrPath,requestPath];
            NSLog(@"%@",path);
            WaitDataView *wait = [[WaitDataView alloc] init];
            if ([self.delegete isKindOfClass:[UIViewController class]]) {
                wait.parentView = ((UIViewController *)self.delegete).view;
            }else wait.parentView = nil;
            [wait displayActivityView];
            path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:path]];
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            request.requestMethod = @"POST";
            if (params) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
                NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
                [request setPostBody:tempJsonData];
            }
            
            
            request.timeOutSeconds = 25;
            __block  ASIFormDataRequest *weakRequest = request;
            [request setCompletionBlock:^{
                respondData = weakRequest.responseData;
                [wait removeActivityView];
                if (self.delegete == nil) {
                }else{
                    [self.delegete dealWithReturnedDataWithNetWork:self];
                }
                [weakRequest clearDelegatesAndCancel];
            }];
            //如果请求发送失败，则调出警告框
            [request setFailedBlock:
             ^{
                 [weakRequest clearDelegatesAndCancel];
                 [wait removeActivityView];
             }];
            if (type == 0) {
                [weakRequest startAsynchronous];
            }else [weakRequest startSynchronous];
        }
    }
}


@end
