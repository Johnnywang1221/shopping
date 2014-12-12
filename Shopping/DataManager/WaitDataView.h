//
//  WaitDataView.h
//  FreeNovelReading
//
//  Created by LHZT on 14-2-9.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNBlurModalView.h"

@interface WaitDataView : UIImageView

@property (nonatomic,retain) UIView *parentView;
@property (nonatomic,retain) NSString *title;

- (void)displayActivityView;
- (void)removeActivityView;
- (void)show;
- (void)hide;

@end
