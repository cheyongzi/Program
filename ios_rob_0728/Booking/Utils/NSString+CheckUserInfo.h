//
//  NSString+CheckUserInfo.h
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckUserInfo)

/*
 * 验证用户手机号是否符合要求
 */
- (BOOL)checkUserPhoneNumber;

/*
 * 验证邮箱是否符合要求
 */
- (BOOL)checkUserMailNumber;

/*
 * 字符串进行md5加密
 */
- (NSString *)md5;

@end
