//
//  sexViewController.h
//  LHZT78
//
//  Created by apple on 13-10-12.
//  Copyright (c) 2013年 feiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"

@interface sexViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetWorkManagerDelegete>

@property (strong ,nonatomic) IBOutlet UITableView*mtableView;
@property (nonatomic ,retain) NSString *selectedSex;

@end
