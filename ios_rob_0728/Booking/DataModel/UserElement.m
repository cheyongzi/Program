//
//  UserElement.m
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserElement.h"

/*
 * 用户信息数据模型
 */
@implementation UserElement

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.sessionId forKey:@"sessionId"];
    [aCoder encodeObject:self.memberId forKey:@"memberId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.contact forKey:@"contact"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.logoUrl forKey:@"logoUrl"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.inviteCode forKey:@"inviteCode"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
        self.memberId= [aDecoder decodeObjectForKey:@"memberId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.contact = [aDecoder decodeObjectForKey:@"contact"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.logoUrl = [aDecoder decodeObjectForKey:@"logoUrl"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.inviteCode = [aDecoder decodeObjectForKey:@"inviteCode"];
    }
    return self;
}

@end
