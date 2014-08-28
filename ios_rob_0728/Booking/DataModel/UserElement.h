//
//  UserElement.h
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 用户信息数据模型
 */
@interface UserElement : NSObject

@property (strong, nonatomic) NSString *userCode ;
@property (strong, nonatomic) NSString *sessionId ;
@property (strong, nonatomic) NSString *memberId ;
@property (strong, nonatomic) NSString *name ;
@property (strong, nonatomic) NSString *contact;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *logoUrl ;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *inviteCode;

@end
