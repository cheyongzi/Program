//
//  AcceptOrderResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AcceptOrderResponse.h"

/*
 * 商家应单响应类
 */
@implementation AcceptOrderResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            NSArray *shopsAry = [bodyDic objectForKey:@"accepts"];
            self.accAry = [[NSMutableArray alloc] init];
            if(shopsAry != nil && [shopsAry count]>0){
                for (NSDictionary *orderDic in shopsAry) {
                    AcceptOrderElement *element = [JsonUtils jsonAcceptOrderElement:orderDic];
                    [self.accAry addObject:element];
                }
            }
        }
    }
}

@end
