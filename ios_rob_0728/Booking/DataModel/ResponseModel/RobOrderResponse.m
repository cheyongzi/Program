//
//  RobOrderResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "RobOrderResponse.h"
/*
 * 抢单返回响应类
 */
@implementation RobOrderResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
    }
}

@end
