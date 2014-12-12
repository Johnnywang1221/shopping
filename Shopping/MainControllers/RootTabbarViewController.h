//
//  RootTabbarViewController.h
//  EducationApp
//
//  Created by Darwin on 14/11/5.
//  Copyright (c) 2014年 lhzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"


@interface RootTabbarViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic,retain)UINavigationController *first;
@property (nonatomic,retain)UINavigationController *second;
@property (nonatomic,retain)UINavigationController *third;
@property (nonatomic,retain)UINavigationController *fourth;


+ (RootTabbarViewController *)sharedTabbar;

@end
