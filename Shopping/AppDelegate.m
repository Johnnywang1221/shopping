//
//  AppDelegate.m
//  Shopping
//
//  Created by Darwin on 14/12/12.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabbarViewController.h"
#import "UMSocial.h"
#import "MobClick.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMSocialData setAppKey:@"53f9e813fd98c528ca011675"];
    [MobClick startWithAppkey:@"53f9e813fd98c528ca011675"];
    //[MobClick startWithAppkey:@"53f9e813fd98c528ca011675" reportPolicy:0 channelId:@"同步推"];
    [MobClick updateOnlineConfig];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialData defaultData].extConfig.title = @"我在玩最近非常火的一款软件《全民大冲关》啦，有强大的题库囊括各类知识，免费在线做题，还可以在线抽奖！感觉非常棒哦，一起来玩儿吧？";
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:@"https://itunes.apple.com/us/app/quan-min-da-chong-guan-bu/id913189469?l=zh&ls=1&mt=8"];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/us/app/quan-min-da-chong-guan-bu/id913189469?l=zh&ls=1&mt=8";
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"53f9e813fd98c528ca011675" url:@"https://itunes.apple.com/us/app/quan-min-da-chong-guan-bu/id913189469?l=zh&ls=1&mt=8"];
    
    [UMSocialQQHandler setSupportWebView:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[RootTabbarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
