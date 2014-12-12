//
//  WaitDataView.m
//  FreeNovelReading
//
//  Created by LHZT on 14-2-9.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "ActivityView.h"
#import "WaitDataView.h"

@implementation WaitDataView

- (void)show{
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        self.center = CGPointMake([[UIScreen mainScreen] bounds].size.height/2, [[UIScreen mainScreen] bounds].size.width/3*2);
    }else{
        self.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/3*2);
    }
    [self.parentView addSubview:self];
}

- (void)hide{
    [self removeFromSuperview];
}

- (void)displayActivityView
{
    if (self.title.length < 2) {
        self.title = @"玩儿命加载中...";
    }
    [BezelActivityView activityViewForView:self.parentView withLabel:self.title width:100];
    //[ActivityView activityViewForView:viewToUse withLabel:@"加载中..." width:self.labelWidth];
    [ActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    //[self performSelector:@selector(removeActivityView) withObject:nil afterDelay:5.0];
}

- (void)removeActivityView
{
    [BezelActivityView removeViewAnimated:YES];
    [ActivityView removeView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
