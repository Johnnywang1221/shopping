//
//  MenuTableViewCell.m
//  MenuTable
//
//  Created by Darwin on 14-5-6.
//  Copyright (c) 2014年 DarWin. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.selectImg = [[UIImageView alloc] init];
        self.selectImg.image = [UIImage imageNamed:@"menuArrow"];
        [self.contentView addSubview:self.selectImg];
        self.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        self.layer.borderWidth = 0.75;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
