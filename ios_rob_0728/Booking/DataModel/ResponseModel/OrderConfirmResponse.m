//
//  OrderConfirmResponse.m
//  Booking
//
//  Created by jinchenxin on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "OrderConfirmResponse.h"
/*
 * 订单确认的响应类
 */
@implementation OrderConfirmResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        NSDictionary *dataDic = [paramDic objectForKey:@"data"];
        NSDictionary *codeDic = [dataDic objectForKey:@"code"];
        self.code = [[codeDic objectForKey:@"state"] integerValue];
        self.message = [codeDic objectForKey:@"message"];
        
        NSDictionary *resultDic = [dataDic objectForKey:@"result"];
        self.payInfo = [resultDic objectForKey:@"info"];
    }
}

@end
