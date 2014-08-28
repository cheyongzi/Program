//
//  LoginResponse.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

- (void)setResultData:(id)inParam
{
    NSDictionary *dataDic = (NSDictionary *)inParam;
    NSDictionary *bodyDic = [[dataDic objectForKey:@"body"] objectForKey:@"user"];
    self.userElement = [JsonUtils jsonUserElement:bodyDic];
}

@end
