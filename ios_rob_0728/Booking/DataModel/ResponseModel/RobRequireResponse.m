//
//  RobRequireResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "RobRequireResponse.h"
#import "RequireElement.h"
/*
 * 抢单需求响应类
 */
@implementation RobRequireResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *resultDic = [paramDic objectForKey:@"result"];
        self.code = [[resultDic objectForKey:@"code"] integerValue];
        self.message = [resultDic objectForKey:@"message"];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            NSArray *robOrdersAry = [bodyDic objectForKey:@"robOrders"];
            if(robOrdersAry != nil && [robOrdersAry count]>0){
                self.robRequireAry = [[NSMutableArray alloc] init];
                for (NSDictionary *orderDic in robOrdersAry) {
                    RequireElement *requireElement = [JsonUtils jsonRequireElement:orderDic];
                    [self.robRequireAry addObject:requireElement];
                }
            }
        }
    }
}

@end
