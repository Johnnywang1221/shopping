//
//  RootTabbarViewController.m
//  EducationApp
//
//  Created by Darwin on 14/11/5.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import "RootTabbarViewController.h"

@interface RootTabbarViewController ()

@end

@implementation RootTabbarViewController

static RootTabbarViewController *tabbar;

+ (RootTabbarViewController *)sharedTabbar
{
    if (tabbar == nil) {
        tabbar = [[RootTabbarViewController alloc] init];
    }
    return tabbar;
}

-(id)init {
    if ([super init] != nil) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        self.first = [[UINavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
        self.first.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        self.second = [[UINavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]];
        self.second.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        self.third = [[UINavigationController alloc] initWithRootViewController:[[ThirdViewController alloc] init]];
        self.third.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        self.fourth = [[UINavigationController alloc] initWithRootViewController:[[FourthViewController alloc] init]];
        self.fourth.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        
        self.first.title = @"first";
        self.second.title = @"second";
        self.third.title = @"third";
        self.fourth.title = @"fourth";
        
        [self.first.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"nav_ask"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_ask"]] ;
        [self.second.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"nav_chat"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_chat"]] ;
        [self.third.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"nav_self"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_self"]] ;
         [self.fourth.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"nav_self"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_self"]] ;
        
        if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 7) {
            self.first.navigationBar.tintColor = [UIColor whiteColor];
            self.second.navigationBar.tintColor = [UIColor whiteColor];
            self.third.navigationBar.tintColor = [UIColor whiteColor];
            self.fourth.navigationBar.tintColor = [UIColor whiteColor];
            self.first.navigationBar.barTintColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
            self.second.navigationBar.barTintColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
            self.third.navigationBar.barTintColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
            self.fourth.navigationBar.barTintColor = [UIColor colorWithRed:77/255.0 green:200/255.0 blue:210/255.0 alpha:1];
        }
    }
    
    if([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] < 7) {
        [self.first.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBg"] forBarMetrics:UIBarMetricsDefault];
        [self.second.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBg"] forBarMetrics:UIBarMetricsDefault];
        [self.third.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBg"] forBarMetrics:UIBarMetricsDefault];
        [self.fourth.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBg"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_footer_bg"]];
    self.tabBar.tintColor = [UIColor darkGrayColor];
    NSArray *viewControllerArray = [NSArray arrayWithObjects:self.first,self.second,self.third,self.fourth,nil];
    self.viewControllers = viewControllerArray;
    self.selectedIndex = 0;
    return self;
}

@end
