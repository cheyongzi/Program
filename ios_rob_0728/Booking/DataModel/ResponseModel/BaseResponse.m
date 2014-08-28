//
//  BaseResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseResponse.h"
/*
 * 数据响应基类
 */
@implementation BaseResponse

-(void) setHeadData:(id) inParam {
    NSDictionary *paramDic = (NSDictionary *) inParam ;
    NSDictionary *resultDic = [paramDic objectForKey:@"result"];
    self.code = [[resultDic objectForKey:@"code"] integerValue];
    self.message = [resultDic objectForKey:@"msg"];
    
    NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
    self.index = [[bodyDic objectForKey:@"index"] integerValue];
    self.pageSize = [[bodyDic objectForKey:@"pageSize"] integerValue];
    self.totalPage = [[bodyDic objectForKey:@"totalPage"] integerValue];
    self.totalRecord = [[bodyDic objectForKey:@"totalRecord"] integerValue];
}

@end
