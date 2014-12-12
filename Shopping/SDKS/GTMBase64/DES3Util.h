//
//  DES3Util.h
//  Base64Test
//
//  Created by LHZT on 13-10-17.
//  Copyright (c) 2013年 LHZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
